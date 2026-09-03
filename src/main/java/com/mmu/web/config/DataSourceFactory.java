package com.mmu.web.config;

import java.time.Duration;
import java.util.Collections;
import java.util.regex.Pattern;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.core.env.Environment;

/**
 * Builds the pooled DataSources used by {@link HibernateConfiguration} and
 * {@link HibernateConfigurationMis}.
 *
 * <p>Both previously used Spring's {@code DriverManagerDataSource}, which is
 * explicitly not a pool — it opens a brand new physical connection on every
 * {@code getConnection()} call. Measured against the running application, that
 * cost roughly two new Postgres backends per API call, each one a TCP connect
 * plus a server-side process fork holding ~15MB.
 *
 * <p>The {@code hibernate.c3p0.*} entries in {@code application-prod.properties}
 * never had any effect: Hibernate ignores its own connection-provider settings
 * when a DataSource is injected into {@code LocalSessionFactoryBean}, which is
 * what these configurations do.
 *
 * <p>Every value below can be overridden from the properties file without a
 * rebuild. Defaults are deliberately conservative because up to four pools
 * (main + MIS, in each of the two applications) may share one database server.
 *
 * <p><b>Sizing resolution.</b> Each setting is looked up most-specific first:
 * <ol>
 * <li>the pool's own key, derived from its url key -- {@code jdbc.pool.maxTotal}
 *     for the main pool, {@code jdbc.mis.pool.maxTotal} for the MIS pool;</li>
 * <li>the shared {@code jdbc.pool.*} key;</li>
 * <li>the built-in default passed by the calling configuration.</li>
 * </ol>
 * The middle step is why an existing {@code -Djdbc.pool.maxTotal=15} keeps
 * working exactly as before: it previously sized all four pools at once, which
 * is precisely the limitation the per-pool keys remove. Nothing configured means
 * the built-in default still applies, so this is safe to deploy with no
 * properties added at all. The startup line prints which key won.
 */
final class DataSourceFactory {

	private DataSourceFactory() {
	}

	static BasicDataSource build(Environment env, String poolName, String urlKey, String userKey,
			String passwordKey, int defaultMaxTotal) {
		return build(env, poolName, urlKey, userKey, passwordKey, defaultMaxTotal, null);
	}

	/**
	 * @param initSql executed once on each new <em>physical</em> connection, not on
	 *                every borrow, so whatever it sets persists for the pooled
	 *                connection's lifetime. Only safe for a pool whose every
	 *                consumer wants the same session settings. May be null.
	 */
	static BasicDataSource build(Environment env, String poolName, String urlKey, String userKey,
			String passwordKey, int defaultMaxTotal, String initSql) {

		BasicDataSource ds = new BasicDataSource();
		ds.setDriverClassName(env.getRequiredProperty("jdbc.driverClassName"));
		ds.setUrl(env.getRequiredProperty(urlKey));
		ds.setUsername(env.getRequiredProperty(userKey));
		ds.setPassword(env.getRequiredProperty(passwordKey));

		// Per-pool prefix derived from the url key: "jdbc.url" -> "jdbc.pool.",
		// "jdbc.mis.url" -> "jdbc.mis.pool.". Every knob below resolves
		//     <pool prefix>key  ->  jdbc.pool.key  ->  the default argued here
		// so each pool can be sized independently, the existing global key still
		// works unchanged, and an absent property keeps the hardcoded default.
		String prefix = poolPrefix(urlKey);

		ds.setInitialSize(intProp(env, prefix, "initialSize", 5));
		ds.setMinIdle(intProp(env, prefix, "minIdle", 5));
		ds.setMaxIdle(intProp(env, prefix, "maxIdle", defaultMaxTotal));
		ds.setMaxTotal(intProp(env, prefix, "maxTotal", defaultMaxTotal));

		// Wait for a free connection when saturated, but never indefinitely —
		// a request that fails after 30s is far easier to diagnose than a hang.
		ds.setMaxWait(Duration.ofMillis(longProp(env, prefix, "maxWaitMillis", 30000L)));

		// Idle connections get dropped by the server and by firewalls; verify
		// before handing one out rather than failing inside business code.
		ds.setValidationQuery("SELECT 1");
		ds.setTestOnBorrow(true);
		ds.setTestWhileIdle(true);
		ds.setTimeBetweenEvictionRunsMillis(longProp(env, prefix, "evictionRunMillis", 30000L));

		// This is what makes a bounded pool safe to introduce *before* the
		// session-handling fix. Many DAO methods call CloseConnection() only on
		// the happy path, so a thrown exception strands the Hibernate session —
		// and its connection — on a pooled Tomcat worker thread permanently.
		// Unbounded, that leaks connections; bounded, it would fill the pool and
		// hang the application. Reclaiming abandoned connections prevents both.
		//
		// logAbandoned captures a stack trace on every borrow, which is not free.
		// It is on by default because it names the exact leaking call sites; set
		// jdbc.pool.logAbandoned=false once those are fixed.
		ds.setRemoveAbandonedOnBorrow(true);
		ds.setRemoveAbandonedOnMaintenance(true);
		ds.setRemoveAbandonedTimeout(
				Duration.ofSeconds(longProp(env, prefix, "removeAbandonedTimeoutSeconds", 300L)));
		ds.setLogAbandoned(boolProp(env, prefix, "logAbandoned", true));

		if (initSql != null && !initSql.trim().isEmpty()) {
			ds.setConnectionInitSqls(Collections.singletonList(initSql));
		}

		System.out.println("[" + poolName + "] pooled DataSource ready: maxTotal=" + ds.getMaxTotal()
				+ " (from " + resolvedFrom(env, prefix, "maxTotal", defaultMaxTotal) + ")"
				+ ", maxIdle=" + ds.getMaxIdle() + ", minIdle=" + ds.getMinIdle()
				+ ", url=" + ds.getUrl()
				+ (initSql == null ? "" : ", initSql=" + initSql));
		return ds;
	}

	/**
	 * Builds a {@code SET work_mem} statement from a properties value.
	 *
	 * <p>The value is interpolated into SQL, so it is validated against Postgres'
	 * memory-unit grammar rather than trusted. A bad value would otherwise fail on
	 * every physical connection the pool opens, surfacing as an unrelated-looking
	 * connection error long after the edit that caused it.
	 *
	 * @return null when unset or blank, meaning "leave the server default alone"
	 */
	static String workMemInitSql(Environment env, String key) {
		String value = env.getProperty(key, "").trim();
		if (value.isEmpty()) {
			return null;
		}
		if (!WORK_MEM.matcher(value).matches()) {
			throw new IllegalArgumentException(key + "='" + value
					+ "' is not a valid work_mem size — expected e.g. 32MB, 512kB or a bare integer (kB)");
		}
		return "SET work_mem = '" + value + "'";
	}

	private static final Pattern WORK_MEM = Pattern.compile("(?i)^\\d+\\s*(kB|MB|GB|TB)?$");

	/** "jdbc.url" -> "jdbc.pool." ; "jdbc.mis.url" -> "jdbc.mis.pool." */
	private static String poolPrefix(String urlKey) {
		String base = urlKey.endsWith(".url")
				? urlKey.substring(0, urlKey.length() - "url".length())
				: "jdbc.";
		return base + "pool.";
	}

	/**
	 * Resolves one pool setting, most specific first: the pool's own key, then the
	 * shared {@code jdbc.pool.*} key, then the caller's default. Returning null
	 * means "nothing configured, use the default".
	 */
	private static String lookup(Environment env, String prefix, String name) {
		String value = env.getProperty(prefix + name);
		if (value == null || value.trim().isEmpty()) {
			value = env.getProperty("jdbc.pool." + name);
		}
		return (value == null || value.trim().isEmpty()) ? null : value.trim();
	}

	/** Which key actually supplied the value, for the startup line. */
	private static String resolvedFrom(Environment env, String prefix, String name, int fallback) {
		String specific = env.getProperty(prefix + name);
		if (specific != null && !specific.trim().isEmpty()) {
			return prefix + name;
		}
		String global = env.getProperty("jdbc.pool." + name);
		if (global != null && !global.trim().isEmpty()) {
			return "jdbc.pool." + name;
		}
		return "built-in default " + fallback;
	}

	private static int intProp(Environment env, String prefix, String name, int fallback) {
		String value = lookup(env, prefix, name);
		return value == null ? fallback : Integer.parseInt(value);
	}

	private static long longProp(Environment env, String prefix, String name, long fallback) {
		String value = lookup(env, prefix, name);
		return value == null ? fallback : Long.parseLong(value);
	}

	private static boolean boolProp(Environment env, String prefix, String name, boolean fallback) {
		String value = lookup(env, prefix, name);
		return value == null ? fallback : Boolean.parseBoolean(value);
	}
}

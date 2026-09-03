package com.mmu.web.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;


@Configuration
@EnableTransactionManagement
@ComponentScan({ "com.mmu.web.config" })
@PropertySource("classpath:application-prod.properties")
//@PropertySource("classpath:application-testing.properties")
@EnableWebMvc
public class HibernateConfigurationMis {

	@Autowired
	private Environment environment;

	@Bean()
	public LocalSessionFactoryBean sessionFactory2() {
		LocalSessionFactoryBean sessionFactory2 = new LocalSessionFactoryBean();
		sessionFactory2.setDataSource(dataSource2());
		sessionFactory2.setPackagesToScan(new String[] { "com.mmu.web.entity" });
		sessionFactory2.setHibernateProperties(hibernateProperties());
		return sessionFactory2;
	}
	

	@Bean(destroyMethod = "close")
	public DataSource dataSource2() {
		// Smaller than the main pool: the MIS datasource serves reporting paths only.
		//
		// Every consumer of this pool is a Jasper report — ~190 call sites, all of
		// them reportDao.getConnectionForReportMis() in ReportWebController and
		// StoresWebController. Nothing else injects sessionFactory2. That is what
		// makes a pool-wide work_mem safe here and NOT on the main pool, which
		// serves ordinary OLTP requests that would gain nothing from it.
		//
		// Registers that aggregate a wide date range sort and de-duplicate far more
		// rows than the 4MB server default holds, so the sort spills to disk. Raising
		// it to 32MB keeps those in memory. See jdbc.mis.workMem in
		// application-prod.properties for the sizing arithmetic and its limits.
		return DataSourceFactory.build(environment, "MMUWeb-mis",
				"jdbc.mis.url", "jdbc.mis.username", "jdbc.mis.password", 10,
				DataSourceFactory.workMemInitSql(environment, "jdbc.mis.workMem"));
	}
	
	
	private Properties hibernateProperties() {
		Properties properties = new Properties();
		properties.put("hibernate.dialect", environment.getRequiredProperty("hibernate.dialect").trim());
		properties.put("hibernate.show_sql", environment.getRequiredProperty("hibernate.show_sql").trim());
		properties.put("hibernate.format_sql", environment.getRequiredProperty("hibernate.format_sql").trim());
		properties.put("hibernate.autoReconnect", environment.getRequiredProperty("hibernate.autoReconnect").trim());
		properties.put("hibernate.c3p0.min_size", environment.getProperty("hibernate.c3p0.min_size").trim());
		properties.put("hibernate.c3p0.max_size", environment.getProperty("hibernate.c3p0.max_size").trim());
		properties.put("hibernate.c3p0.timeout", environment.getProperty("hibernate.c3p0.timeout").trim());
		properties.put("hibernate.c3p0.max_statements",
				environment.getProperty("hibernate.c3p0.max_statements").trim());
		properties.put("hibernate.c3p0.idle_test_period",
				environment.getProperty("hibernate.c3p0.idle_test_period").trim());
		properties.put("hibernate.c3p0.acquire_increment",
				environment.getProperty("hibernate.c3p0.acquire_increment").trim());
		properties.put("hibernate.c3p0.acquireRetryAttempts",
				environment.getProperty("hibernate.c3p0.acquireRetryAttempts").trim());
		properties.put("hibernate.c3p0.acquireRetryDelay",
				environment.getProperty("hibernate.c3p0.acquireRetryDelay").trim());
		properties.put("hibernate.enable_lazy_load_no_trans",
				environment.getProperty("hibernate.enable_lazy_load_no_trans").trim());

		return properties;
	}

	@Bean
	@Autowired
	public HibernateTransactionManager transactionManager2(@Qualifier("sessionFactory2") SessionFactory s) {
		HibernateTransactionManager txManager = new HibernateTransactionManager();
		txManager.setSessionFactory(s);
		return txManager;
	}

}

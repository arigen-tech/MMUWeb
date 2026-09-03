package com.mmu.web.hibernateutils;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Releases the thread-local Hibernate sessions at the end of every request.
 *
 * <p>DAO methods call {@code CloseConnection()} themselves, but most do so on the
 * happy path rather than from a {@code finally} block. When one throws, the
 * session stays bound to the {@code ThreadLocal} of a pooled Tomcat worker
 * thread and is never reclaimed — measured against this application as
 * connections stuck in {@code idle in transaction (aborted)} for the better part
 * of an hour, each holding roughly 15MB and blocking VACUUM across the database.
 *
 * <p>This is a net rather than a replacement: {@code CloseConnection()}
 * null-checks the ThreadLocal, so for every DAO that already closed correctly
 * this filter is a no-op. It only acts on the paths that failed to get there.
 *
 * <p>Registered on {@code /*} by {@code WebAppInitializer}.
 */
@Component("hibernateSessionCleanupFilter")
public class HibernateSessionCleanupFilter implements Filter {

	@Autowired
	private GetHibernateUtils getHibernateUtils;

	@Autowired
	private GetHibernateUtilsMis getHibernateUtilsMis;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// nothing to configure
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		try {
			chain.doFilter(request, response);
		} finally {
			releaseMain();
			releaseMis();
		}
	}

	/**
	 * Cleanup must never turn a served request into a failed one, so both
	 * releases swallow their own failures independently — a problem closing the
	 * main session must not prevent the MIS session from being released.
	 */
	private void releaseMain() {
		try {
			if (getHibernateUtils != null && getHibernateUtils.getHibernateUtlis() != null) {
				getHibernateUtils.getHibernateUtlis().CloseConnection();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void releaseMis() {
		try {
			if (getHibernateUtilsMis != null && getHibernateUtilsMis.getHibernateUtlisMiss() != null) {
				getHibernateUtilsMis.getHibernateUtlisMiss().CloseConnection();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void destroy() {
		// nothing to release
	}
}

package com.mmu.web.hibernateutils;

import java.sql.Connection;
import java.sql.SQLException;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.engine.jdbc.connections.spi.ConnectionProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

@Component
public class HibernateUtlis {

	@Autowired
	@Qualifier("sessionFactory")
	protected SessionFactory factory;

	ThreadLocal<Session> threadlocal = new ThreadLocal<Session>();

	public HibernateUtlis() {
		System.out.println("HibernateUtlis intilize time");
	}

	public Session OpenSession() {
		Session session = null;
		if (threadlocal.get() == null) {
			session = factory.openSession();
			threadlocal.set(session);
		} else {
			session = threadlocal.get();
			if (!session.isOpen()) {
				threadlocal.remove();
				session = factory.openSession();
				threadlocal.set(session);
			}
		}

		return session;

	}

	/**
	 * Releases the session bound to the current thread.
	 *
	 * The ThreadLocal is cleared *first*: previously clear() ran before
	 * remove(), so a session in an aborted-transaction state — precisely the
	 * kind worth reclaiming — could throw there and leave the session bound to
	 * a pooled Tomcat worker thread permanently. Same order of operations as
	 * before, just made unconditional.
	 */
	public void CloseConnection() {
		Session session = threadlocal.get();
		if (session == null) {
			return;
		}
		threadlocal.remove();
		try {
			if (session.isOpen()) {
				session.clear();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				session.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public Session getCurrentSession() {
		return factory.getCurrentSession();

	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			conn = factory.getSessionFactoryOptions().getServiceRegistry().getService(ConnectionProvider.class)
					.getConnection();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}

}

package com.mmu.web.config;

import java.util.EnumSet;

import javax.servlet.DispatcherType;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		super.onStartup(servletContext);

		// Mapped on /* directly rather than through getServletFilters(), which
		// binds filters to the DispatcherServlet alone and would miss requests
		// served by the JSP and default servlets.
		//
		// REQUEST only, deliberately not FORWARD: the filter must wrap the
		// outermost request so it cannot close a session mid-flight when a
		// controller forwards to a JSP.
		servletContext
				.addFilter("hibernateSessionCleanupFilter",
						new DelegatingFilterProxy("hibernateSessionCleanupFilter"))
				.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), false, "/*");
	}

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { WebApplicationConfig.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return null;
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

}

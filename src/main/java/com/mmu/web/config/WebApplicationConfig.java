package com.mmu.web.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@ComponentScan("com.mmu.web")
@EnableWebMvc
@EnableTransactionManagement
public class WebApplicationConfig extends WebMvcConfigurerAdapter {

	@Autowired
	private Environment environment;

	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}

	/**
	 * One structured log line per request. /resources/** is excluded because a
	 * single page pulls ~38 static assets — logging those would bury the ~1
	 * meaningful line per page view under 38 that say nothing.
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new RequestLoggingInterceptor("MMUWeb", environment))
				.addPathPatterns("/**")
				.excludePathPatterns("/resources/**", "/static/**", "/favicon.ico");
	}

	/**
	 * Was corePoolSize=100 / maxPoolSize=100000. Each Java thread reserves around
	 * 1MB of stack, so that ceiling alone represented a ~100GB reservation and
	 * nothing bounded thread growth under load. The 100 core threads were also
	 * kept alive permanently. Nothing in either application actually injects this
	 * executor, so these bounds are conservative on purpose — raise them
	 * deliberately if async work is ever added.
	 */
	@Bean
	public ThreadPoolTaskExecutor taskExecutor() {
		ThreadPoolTaskExecutor pool = new ThreadPoolTaskExecutor();
		pool.setCorePoolSize(10);
		pool.setMaxPoolSize(50);
		pool.setQueueCapacity(200);
		pool.setKeepAliveSeconds(60);
		pool.setThreadNamePrefix("mmu-web-task-");
		pool.setWaitForTasksToCompleteOnShutdown(true);
		pool.setAwaitTerminationSeconds(30);
		return pool;
	}

	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/view/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}

	/**
	 * Static assets under /resources/ previously went out with no Cache-Control
	 * and no ETag — only Last-Modified — so browsers revalidated them
	 * heuristically. A single page references 38 of these files, and there are
	 * 677 of them totalling 71MB, which is why request volume runs roughly 38x
	 * the number of actual page views.
	 *
	 * One hour is deliberately conservative. Asset URLs in the JSPs are
	 * unversioned (${pageContext.request.contextPath}/resources/js/foo.js), so
	 * the cache period is also the worst-case window during which a user can
	 * keep running pre-deploy JavaScript. Raise it once asset URLs carry a
	 * build version.
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**")
				.addResourceLocations("/resources/")
				.setCachePeriod(3600);
	}

	@Bean(name = "messageSource")
	public MessageSource configureMessageSource() {
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("classpath:messages");
		messageSource.setCacheSeconds(5);
		messageSource.setDefaultEncoding("UTF-8");
		return messageSource;
	}

	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver getCommonsMultipartResolver() {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(50971520); // 50MB
		multipartResolver.setMaxInMemorySize(1048576); // 1MB
		return multipartResolver;
	}

}

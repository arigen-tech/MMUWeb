package com.mmu.web.service.schedulers;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.annotation.WebListener;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.ee.servlet.QuartzInitializerListener;
import org.quartz.impl.StdSchedulerFactory;

@WebListener
public class FollowUpMessageScheduler extends QuartzInitializerListener{
	
	 //0 12 * * ?
    private static final String CRON_EXPRESSION_EVERY_MIDNIGHT = "0 30 23 * * ?";
	// private static final String CRON_EXPRESSION_EVERY_MONDAY = "0 35 18 * * ?";
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        super.contextInitialized(sce);
        ServletContext ctx = sce.getServletContext();
        StdSchedulerFactory factory = (StdSchedulerFactory) ctx.getAttribute(QUARTZ_FACTORY_KEY);
        try {
            Scheduler scheduler = factory.getScheduler();
            JobDetail jobDetail = JobBuilder.newJob(FollowUpMessageJobExecution.class).build();
            Trigger trigger = TriggerBuilder.newTrigger()
            		.withIdentity("simple20202")
            		.withSchedule(
            						CronScheduleBuilder.cronSchedule(CRON_EXPRESSION_EVERY_MIDNIGHT))
            		.startNow()
            		.build();
            scheduler.scheduleJob(jobDetail, trigger);
           // scheduler.start();
        } catch (Exception e) {
            ctx.log("There was an error scheduling the job.", e);
        }
    }
 
  

}

/**
 * Initializes Hibernate and JSONify when servlet context is created and then destroys them when it is destroyed.
 * 
 * @author		Edward Y. Chen
 * @since		03/01/2013
 */

package edu.mssm.pharm.maayanlab.X2K.web;

import java.util.Set;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import edu.mssm.pharm.maayanlab.X2K.enrichment.Network;
import edu.mssm.pharm.maayanlab.common.web.JSONify;

@WebListener
public class Context implements ServletContextListener {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Context.class);
	private static Gson gson;
	
	public static JSONify getJSONConverter() {
		return new JSONify(gson);
	}
	
	@Override
	public void contextInitialized(ServletContextEvent event) {
		// Just call the static initializer of that class
//		HibernateUtil.getSessionFactory();
		
		// Register type adapter with JSONify
		GsonBuilder gsonBuilder = new GsonBuilder();
		gsonBuilder.registerTypeAdapter(Network.Node.class, (new Network()).new NodeToJson());
		gsonBuilder.setDateFormat("yyyy/MM/dd HH:mm:ss");
		gsonBuilder.excludeFieldsWithoutExposeAnnotation();
		Context.gson = gsonBuilder.create();
	}       

	@SuppressWarnings("deprecation")
	@Override
	public void contextDestroyed(ServletContextEvent event) {         
//		HibernateUtil.getSessionFactory().close(); // Free all resources
		
		//TODO: find memory leak that requires server to be restarted after hot deploying several (3?) times
		Set<Thread> threadSet = Thread.getAllStackTraces().keySet();        
		for (Thread t : threadSet) {
			if (t.getName().contains("Abandoned connection cleanup thread")) {
                synchronized(t) {
                	LOGGER.warn("Forcibly stopping thread to avoid memory leak: " + t.getName());
                    t.stop();	//don't complain, it works
                }
            }
		}
	}
}
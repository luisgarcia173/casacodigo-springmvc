package br.com.casadocodigo.loja.conf;

import java.util.concurrent.TimeUnit;

import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.guava.GuavaCacheManager;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.format.datetime.DateFormatterRegistrar;
import org.springframework.format.support.DefaultFormattingConversionService;
import org.springframework.format.support.FormattingConversionService;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.google.common.cache.CacheBuilder;

import br.com.casadocodigo.loja.controllers.HomeController;
import br.com.casadocodigo.loja.daos.ProductDAO;
import br.com.casadocodigo.loja.models.ShoppingCart;
import br.com.casadocodigo.loja.utils.FileSaver;

@EnableWebMvc
@ComponentScan(basePackageClasses = { HomeController.class, ProductDAO.class, FileSaver.class, ShoppingCart.class })
@EnableCaching
public class AppWebConfiguration {

	/**
	 * Responsible for register the page suffix, path 
	 * @return
	 */
	@Bean
	public InternalResourceViewResolver internalResourceViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		resolver.setExposedContextBeanNames("shoppingCart");
		return resolver;
	}

	/**
	 * Responsible for register the messages (properties) and i18n
	 * @return
	 */
	@Bean
	public MessageSource messageSource() {
		ReloadableResourceBundleMessageSource bundle = new ReloadableResourceBundleMessageSource();
		bundle.setBasename("/WEB-INF/messages");
		bundle.setDefaultEncoding("UTF-8");
		bundle.setCacheSeconds(1); // Cache for Messages
		return bundle;
	}

	/**
	 * Responsible for register the date formatting
	 * @return
	 */
	@Bean
	public FormattingConversionService mvcConversionService() {
		DefaultFormattingConversionService conversionService = new DefaultFormattingConversionService(true);
		DateFormatterRegistrar registrar = new DateFormatterRegistrar();
		registrar.setFormatter(new DateFormatter("yyyy-MM-dd"));
		registrar.registerFormatters(conversionService);
		return conversionService;
	}

	/**
	 * Resposible for allow the file uploading
	 * @return
	 */
	@Bean
	public MultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver();
	}

	/**
	 * Resposible for register the RestTemplate as BEAN, in order to consume REST services easely
	 * @return
	 */
	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}
	
	/**
	 * Responsible for enable Spring Cache
	 * @return
	 */
	@Bean
	public CacheManager cacheManager(){
		//return new ConcurrentMapCacheManager(); //Simple way to use cache, no config, no time management, no size
		
		// Using guava for caching management
		CacheBuilder<Object, Object> builder = CacheBuilder.newBuilder()
			.maximumSize(100)
			.expireAfterAccess(5, TimeUnit.MINUTES);
		GuavaCacheManager cacheManager = new GuavaCacheManager();
		cacheManager.setCacheBuilder(builder);
		return cacheManager;
	}

}

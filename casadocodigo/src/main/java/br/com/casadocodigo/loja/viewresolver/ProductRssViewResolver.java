package br.com.casadocodigo.loja.viewresolver;

import java.util.Locale;

import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;

public class ProductRssViewResolver implements ViewResolver {

	/*private Marshaller marshaller;

	@Autowired
	public CustomXMLViewResolver(Marshaller marshaller) {
		this.marshaller = marshaller;
	}*/
	
	@Override
	public View resolveViewName(String viewName, Locale locale) throws Exception {
		ProductRssViewer view = new ProductRssViewer();
		//view.setMarshaller(marshaller);
		return view;
	}

}

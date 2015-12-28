package br.com.casadocodigo.loja.viewresolver;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.feed.AbstractRssFeedView;

import com.rometools.rome.feed.rss.Channel;
import com.rometools.rome.feed.rss.Content;
import com.rometools.rome.feed.rss.Item;

import br.com.casadocodigo.loja.models.Product;


public class ProductRssViewer extends AbstractRssFeedView {

	@Override
	protected void buildFeedMetadata(Map<String, Object> model, Channel channel, HttpServletRequest request) {
		channel.setTitle("CasaDoCodigo");
		channel.setLink("http://www.casacodigo.com");
		channel.setDescription("CasaDoCodigo eh um eCommerce de livros.");
		super.buildFeedMetadata(model, channel, request);
	}
	
	@Override
	protected List<Item> buildFeedItems(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/*@SuppressWarnings("unchecked")
		List<Product> listContent = (List<Product>) model.get("books");
		List<Item> items = new ArrayList<Item>(listContent.size());*/
		
		Product product = (Product) model.get("product");
		List<Item> items = new ArrayList<Item>(1);
		
		//for(Product product : listContent ){
			
			Item item = new Item();
			
			Content content = new Content();
			content.setValue(product.getDescription());
			item.setContent(content);
			
			item.setTitle(product.getTitle());
			item.setLink("http://localhost:8080/casadocodigo/produtos/show/"+product.getId());
			item.setPubDate(product.getReleaseDate().getTime());
			
			items.add(item);
		//}
		
		return items;
	}


}

package br.com.casadocodigo.loja.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.com.casadocodigo.loja.daos.ProductDAO;
import br.com.casadocodigo.loja.models.BookType;
import br.com.casadocodigo.loja.models.Product;
import br.com.casadocodigo.loja.models.ShoppingCart;
import br.com.casadocodigo.loja.models.ShoppingItem;

@Controller
@RequestMapping("/shopping")
public class ShoppingCartController {

	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private ShoppingCart shoppingCart;

	@RequestMapping(method=RequestMethod.POST, name="addToCart")
	public ModelAndView add(@ModelAttribute("productId") Integer productId, 
							@ModelAttribute("bookType") BookType bookType,
							@ModelAttribute("quantity") Integer quantity){
		ShoppingItem item = createItem(productId, bookType, quantity);
		shoppingCart.add(item);
		return new ModelAndView("redirect:/produtos");
	}
	
	@RequestMapping(method=RequestMethod.GET, name="showShoppingCart")
	public ModelAndView items(){
		ModelAndView modelAndView = new ModelAndView("shoppingCart/items");
		modelAndView.addObject("items", shoppingCart.getList());
		modelAndView.addObject("cart", shoppingCart);
		return modelAndView;
	}

	private ShoppingItem createItem(Integer productId, BookType bookType, Integer quantity) {
		Product product = productDAO.find(productId);
		ShoppingItem item = new ShoppingItem(product, bookType, quantity);
		return item;
	}

}

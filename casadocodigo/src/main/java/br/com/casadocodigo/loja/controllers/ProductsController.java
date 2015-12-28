package br.com.casadocodigo.loja.controllers;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.casadocodigo.loja.daos.ProductDAO;
import br.com.casadocodigo.loja.models.BookType;
import br.com.casadocodigo.loja.models.Product;
import br.com.casadocodigo.loja.utils.FileSaver;

@Controller
@Transactional
@RequestMapping("/produtos")
public class ProductsController {

	/* Useless, using JSR 303 - Hibernate Validations
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.setValidator(new ProductValidator());
	}*/
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private FileSaver fileSaver;
	
	@RequestMapping(value="/form", name="addProduct")
	public ModelAndView form(Product product) {
		ModelAndView modelAndView = new ModelAndView("products/form");
		modelAndView.addObject("types", BookType.values());
		return modelAndView;
	}
	
	@RequestMapping(method=RequestMethod.GET, name="listProducts")
	@Cacheable(value="books")
	public ModelAndView list() {
		ModelAndView modelAndView = new ModelAndView("products/list");
		modelAndView.addObject("products", productDAO.list());
		modelAndView.addObject("productsNewest", productDAO.listNewest());
		return modelAndView;
	}
	
	@RequestMapping(method=RequestMethod.POST, name="saveProduct")
	@CacheEvict(value="books", allEntries=true)
	public ModelAndView save(MultipartFile summary, @Valid Product product, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		if(bindingResult.hasErrors()){
			return form(product);
		}
		if (StringUtils.hasText(summary.getOriginalFilename())) {
			String webPath = fileSaver.write("uploaded-images",summary);
			product.setSummaryPath(webPath);
		}
		productDAO.save(product);
		redirectAttributes.addFlashAttribute("sucesso", "Produto cadastrado com sucesso."); //valid for this request
		return new ModelAndView("redirect:produtos");
	}
	
	@RequestMapping(method=RequestMethod.GET, value="/show/{id}", name="showProduct")
	public ModelAndView show(@PathVariable("id") Integer id){
		ModelAndView modelAndView = new ModelAndView("products/show");
		Product product = productDAO.find(id);
		modelAndView.addObject("product", product);
		return modelAndView;
	}

}

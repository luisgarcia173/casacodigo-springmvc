package br.com.casadocodigo.loja.controllers;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.com.casadocodigo.loja.daos.UserDAO;
import br.com.casadocodigo.loja.models.Role;
import br.com.casadocodigo.loja.models.User;

@Controller
@Transactional
@RequestMapping("/usuarios")
public class UsersController {

	@Autowired
	private UserDAO userDAO;
	
	@RequestMapping(value="/form", name="addUser")
	public ModelAndView form(User user, Role role) {
		ModelAndView modelAndView = new ModelAndView("users/form");
		modelAndView.addObject("users", userDAO.listUsers());
		modelAndView.addObject("roles", userDAO.listRoles());
		return modelAndView;
	}
	
	@RequestMapping(method=RequestMethod.POST, name="saveUser", value="/user")
	public ModelAndView saveUser(@Valid User user, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		if(bindingResult.hasErrors()){
			return form(user, null);
		}
		userDAO.saveUser(user);
		redirectAttributes.addFlashAttribute("sucesso", "Usuário cadastrado com sucesso."); //valid for this request
		return new ModelAndView("redirect:usuarios");
	}
	
	@RequestMapping(method=RequestMethod.POST, name="saveRole", value="/role")
	public ModelAndView saveRole(@Valid Role role, BindingResult bindingResult, RedirectAttributes redirectAttributes) {
		if(bindingResult.hasErrors()){
			return form(null, role);
		}
		userDAO.saveRole(role);
		redirectAttributes.addFlashAttribute("sucesso", "Role cadastrada com sucesso."); //valid for this request
		return new ModelAndView("redirect:usuarios");
	}

}

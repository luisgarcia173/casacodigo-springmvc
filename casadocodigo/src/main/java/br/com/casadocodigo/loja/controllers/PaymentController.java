package br.com.casadocodigo.loja.controllers;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.async.DeferredResult;
import org.springframework.web.servlet.ModelAndView;

import br.com.casadocodigo.loja.mail.Mail;
import br.com.casadocodigo.loja.mail.MailBuilder;
import br.com.casadocodigo.loja.models.PaymentData;
import br.com.casadocodigo.loja.models.ShoppingCart;
import br.com.casadocodigo.loja.models.User;
import br.com.casadocodigo.loja.service.IntegrandoComPagamento;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	private ShoppingCart shoppingCart;
	@Autowired
	private RestTemplate restTemplate;

	@RequestMapping(method = RequestMethod.POST, name = "itemsCheckoutSync", value="/checkoutSync")
	public ModelAndView checkoutSync(@AuthenticationPrincipal User user) {
		ModelAndView modelAndView = new ModelAndView("payment/success");
		BigDecimal total = shoppingCart.getTotal();
		String uriToPay = "http://book-payment.herokuapp.com/payment"; //REST service for payments, allow max R$ 500 per transaction
		try {
			String response = restTemplate.postForObject(uriToPay, new PaymentData(total), String.class);
			
			//sendNewPurchaseMail(user); // To be tested
			
			shoppingCart.cleanCart();
			modelAndView.addObject("paymentMessage", response);
		} catch (HttpClientErrorException exception) {
			modelAndView.addObject("paymentMessage", "Transação não foi aceita pela operadora");
		}
		return modelAndView;
	}
	
	/**
	 * Asynchronous call
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, name = "itemsCheckoutAsync", value="/checkoutAsync")
	public DeferredResult<ModelAndView> checkoutAsync(@AuthenticationPrincipal User user) {
		BigDecimal total = shoppingCart.getTotal();
		DeferredResult<ModelAndView> result = new DeferredResult<ModelAndView>();

		IntegrandoComPagamento integrandoComPagamento = new IntegrandoComPagamento(result, total, restTemplate);
		
		Thread thread = new Thread(integrandoComPagamento);
		thread.start();
		return result;
	}
	
	@SuppressWarnings("unused")
	private void sendNewPurchaseMail(User user) {
		Mail mail = new MailBuilder().from("compras@casadocodigo.com.br")
									 .to(user.getLogin())
									 .subject("Nova Compra")
									 .body("Compra realizada com sucesso.")
									 .create();
		mail.send();
	}

}

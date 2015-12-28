package br.com.casadocodigo.loja.models;

import java.math.BigDecimal;
import java.util.Arrays;

import lombok.EqualsAndHashCode;
import lombok.Getter;

@EqualsAndHashCode
public class ShoppingItem {

	private @Getter Product product;
	private @Getter BookType bookType;
	private Integer productId;
	private @Getter Integer quantity;
	
	public static ShoppingItem zeroed(){
		Product product = new Product();
		Price price = new Price();
		BookType combo = BookType.COMBO;
		price.setBookType(combo);
		price.setValue(BigDecimal.ZERO);
		product.setPrices(Arrays.asList(price));
		return new ShoppingItem(product, combo, 0);
	}

	public ShoppingItem(Product product, BookType bookType, Integer quantity) {
		this.product = product;
		this.bookType = bookType;
		this.productId = product.getId();
		this.quantity = quantity;
	}
	
	public BigDecimal getPrice(){
		return product.priceFor(bookType);
	}
	
	public BigDecimal getTotal() {
		return getPrice().multiply(new BigDecimal(quantity));
	}
	
	public BigDecimal getTotal(int quantity) {
		return getPrice().multiply(new BigDecimal(quantity));
	}
	
}

package br.com.casadocodigo.loja.models;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Entity
public @Data class Product {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@NotBlank
	private String title;
	@Lob
	@NotBlank
	private String description;
	@Min(30)
	private int pages;
	@ElementCollection
	private List<Price> prices = new ArrayList<Price>();
	@DateTimeFormat
	private Calendar releaseDate;
	private String summaryPath;
	
	public BigDecimal priceFor(BookType bookType) {
		BigDecimal value = new BigDecimal(0);
		for (Price price : prices) {
			if (price.getBookType().equals(bookType)) {
				value = price.getValue();
			}
		}
		return value;
	}
	
}

package br.com.casadocodigo.loja.models;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import lombok.Data;

@Embeddable
public @Data class Price {

	@Column(scale = 2)
	private BigDecimal value;
	private BookType bookType;
	
}

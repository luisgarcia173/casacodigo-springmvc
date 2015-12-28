<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
</head>
<body>

	<div class="top-bar">
		<div class="top-bar-left">
			<ul class="menu">
				<li class="menu-text">Catalogo de Livros</li>
				<li><a href="${spring:mvcUrl('listProducts').build()}">Listar</a></li>
				<li><a href="${spring:mvcUrl('addProduct').build()}">Cadastrar</a></li>
			</ul>
		</div>
		<div class="top-bar-right">
			<ul class="menu">
				<li><a href="${spring:mvcUrl('showShoppingCart').build()}" rel="nofollow">Seu carrinho (${shoppingCart.quantityDistinctItems})</a></li>
				<li><a href="#">Logout</a></li>
			</ul>
		</div>
	</div>

	<div class="row column text-center">
		<h2>Resumo Compras</h2>
		<hr>
	</div>

	<div class="row">
		<div class="large-12 columns">
			<table>
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th>Item</th>
						<th width="150">Formato</th>
						<th width="150">Preço</th>
						<th width="150">Quantidade</th>
						<th width="150">Total</th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td colspan="4"></td>
						<td># ${cart.quantity}</td>
						<td>R$ ${cart.total}</td>
					</tr>
				</tfoot>
				<tbody>
					<c:forEach items="${items}" var="item">
						<tr>
							<%-- <td><a href="${spring:mvcUrl('removeCartProduct').arg(0,item.product.id).build()}"><i class="fa fa-minus-square" style="color: red;"></i></a></td> --%>
							<td><a href="#"><i class="fa fa-minus-square" style="color: red;"></i></a></td>
							<td>${item.product.title}</td>
							<td>${item.bookType}</td>
							<td>${item.price}</td>
							<td>${item.quantity}</td>
							<td>${item.total}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="row text-center">
		<div class="large-12 columns">
			<form action="${spring:mvcUrl('itemsCheckoutSync').build()}" method="post">
				<input type="submit" class="medium button" name="checkout" value="Finalizar compra" id="checkout"/>
			</form>
		</div>
	</div>

	<div class="callout large secondary">
		<div class="row">
			<div class="large-12 columns">
				<h5>Catalogo de Livros</h5>
				<p>Luis Garcia - 2015</p>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="http://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.js"></script>
	<script> $(document).foundation(); </script>
</body>
</html>
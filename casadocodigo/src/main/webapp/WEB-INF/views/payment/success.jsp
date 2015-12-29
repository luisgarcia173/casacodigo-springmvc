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
				
				<!-- Logged Admin User -->
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<li><a href="${spring:mvcUrl('addProduct').build()}">Cadastrar</a></li>
				</security:authorize>
				
			</ul>
		</div>
		<div class="top-bar-right">
			<ul class="menu">

				<!-- Logged User -->
				<security:authorize access="isAuthenticated()">
					<security:authentication property="principal" var="user" />
					<li><a href="${spring:mvcUrl('login').arg(0,'logout').build()}">Logout (${user.name})</a></li>
					<li><a href="${spring:mvcUrl('showShoppingCart').build()}" rel="nofollow">Seu carrinho (${shoppingCart.quantityDistinctItems})</a></li>
				</security:authorize>

				<!-- Anonymous User-->
				<security:authorize access="!isAuthenticated()">
					<li><a href="${spring:mvcUrl('login').build()}">Log In</a></li>
				</security:authorize>
				
			</ul>
		</div>
	</div>

	<div class="row text-center">
		<div class="large-12 columns">
			<div class="panel">
				<h3>Retorno da Transa&ccedil;&atilde;o de Pagamento</h3>
				<p>${paymentMessage}</p>
			</div>
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
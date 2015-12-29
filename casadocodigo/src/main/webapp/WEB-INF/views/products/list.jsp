<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
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
				<li class="menu-text"><spring:message code="general.title"/></li>
				<li><a href="${spring:mvcUrl('listProducts').build()}"><spring:message code="navigation.menu.list"/></a></li>
				
				<!-- Logged Admin User -->
				<security:authorize access="hasRole('ROLE_ADMIN')">
					<li>
						<a href="${spring:mvcUrl('addProduct').build()}"><spring:message code="navigation.menu.books"/></a></li>
					<li><a href="#"><spring:message code="navigation.menu.users"/></a></li>
				</security:authorize>
				
				<li><a href="${spring:mvcUrl('addUser').build()}"><spring:message code="navigation.menu.users"/></a></li>
				
			</ul>
		</div>
		<div class="top-bar-right">
			<ul class="menu">

				<!-- Language Selection -->
				<li>
					<small>(<a href="<c:url value="/produtos?locale=pt"/>"><spring:message code="language.selection.portuguese"/></a>|
					 <a href="<c:url value="/produtos?locale=en_US"/>"><spring:message code="language.selection.english"/></a>)
					 </small>
				</li>

				<!-- Logged User -->
				<security:authorize access="isAuthenticated()">
					<security:authentication property="principal" var="user" />
					<li><spring:message code="users.welcome" arguments="${user.name}"/></li>
					<li><a href="${spring:mvcUrl('showShoppingCart').build()}" rel="nofollow"><spring:message code="navigation.menu.cart"/> (${shoppingCart.quantityDistinctItems})</a></li>
					<li><a href="${spring:mvcUrl('login').arg(0,'logout').build()}">Logout</a></li>
				</security:authorize>

				<!-- Anonymous User-->
				<security:authorize access="!isAuthenticated()">
					<li><a href="${spring:mvcUrl('login').build()}">Log In</a></li>
				</security:authorize>
				
			</ul>
		</div>
	</div>

	<div class="row column text-center">
		<h2>Livros em Lançamento</h2>
		<hr>
	</div>

	<div class="row small-up-2 large-up-4">
		<c:forEach items="${productsNewest}" var="product">
			<div class="column">
				<img class="thumbnail" src="http://placehold.it/300x400">
				<h5>${product.title}</h5>
				<p>
					<c:forEach items="${product.prices}" var="price">
						> ${price.bookType} (R$ ${price.value})
					</c:forEach>
				</p>
				<a href="${spring:mvcUrl('showProduct').arg(0,product.id).build()}" class="button expanded">Comprar</a>
			</div>
		</c:forEach>
	</div>
	<hr>

	<div class="row column text-center">
		<h2>Outros Produtos Interessantes</h2>
		<hr>
	</div>

	<div class="row small-up-2 medium-up-3 large-up-6">
		<c:forEach items="${products}" var="product">
			<div class="column">
				<img class="thumbnail" src="http://placehold.it/300x400">
				<h5>${product.title}</h5>
				<p>
					<c:forEach items="${product.prices}" var="price">
						> ${price.bookType} (R$ ${price.value})
					</c:forEach>
				</p>
				<a href="${spring:mvcUrl('showProduct').arg(0,product.id).build()}" class="button small expanded hollow">Comprar</a>
			</div>
		</c:forEach>
	</div>
	<hr>

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
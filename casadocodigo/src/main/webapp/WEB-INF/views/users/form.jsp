<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta charset="UTF-8">
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

	<div class="row column text-center">
		<h3>User's Roles</h3>
		<hr>
	</div>
	<div class="row">
		<div class="large-4 columns">
			<table>
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th>Nome</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${roles}" var="role">
						<tr>
							<%-- <td><a href="${spring:mvcUrl('removeCartProduct').arg(0,item.product.id).build()}"><i class="fa fa-minus-square" style="color: red;"></i></a></td> --%>
							<td><a href="#"><i class="fa fa-minus-square" style="color: red;"></i></a></td>
							<td>${role.name}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<hr>
	</div>
	
	<div class="row column text-center">
		<h3>User's</h3>
		<hr>
	</div>
	<div class="row">
		<div class="large-12 columns">
			<table>
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th>Nome</th>
						<th>Login</th>
						<th>Role</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users}" var="user">
						<tr>
							<%-- <td><a href="${spring:mvcUrl('removeCartProduct').arg(0,item.product.id).build()}"><i class="fa fa-minus-square" style="color: red;"></i></a></td> --%>
							<td><a href="#"><i class="fa fa-minus-square" style="color: red;"></i></a></td>
							<td>${user.name}</td>
							<td>${user.login}</td>
							<td>${user.roles[0]}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<hr>
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
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

	<form:form method="post" 
			   commandName="product" 
			   enctype="multipart/form-data"
			   action="${spring:mvcUrl('saveProduct').build()}">

		<div class="row">
			<div class="large-12 columns">
				<label>Titulo 
					<form:input path="title"/>
					<form:errors path="title"/>
				</label>
			</div>
		</div>
		
		<div class="row">
		    <div class="large-12 columns">
		      <label>Descrição
		        <form:textarea path="description" rows="10" cols="20"/>
				<form:errors path="description"/>
		      </label>
		    </div>
		  </div>


		<div class="row">
			<div class="large-6 columns">
				<label>Número de paginas 
					<form:input path="pages" /> 
					<form:errors path="pages" />
				</label>
			</div>
			<div class="large-6 columns">
				<label>Data de lançamento 
					<form:input path="releaseDate" type="date" /> 
					<form:errors path="releaseDate" />
				</label>
			</div>
		</div>

		<div class="row">
			<c:forEach items="${types}" var="bookType" varStatus="status">
				<div class="large-4 columns">
					<label for="price_${bookType}">${bookType}
						<input type="text" name="prices[${status.index}].value" id="price_${bookType}" /> 
					    <input type="hidden" name="prices[${status.index}].bookType" value="${bookType}" />
				    </label> 
				</div>
			</c:forEach>
		</div>
			
		<div class="row">
			<div class="large-12 columns">
				<label>Sumario do livro
					<input type="file" name="summary"/>
					<form:errors path="summaryPath"/>
				</label>
			</div>
		</div>
		
		<div class="row text-center">
			<div class="large-12 columns">
				<input type="submit" value="Cadastrar Livro" class="medium button">
			</div>
		</div>
	</form:form>
	
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
	
	<br>
	<div class="row columns">
		<nav aria-label="You are here:" role="navigation">
			<ul class="breadcrumbs">
				<li><a href="#">Home</a></li>
				<li><a href="#">Livros</a></li>
				<li><a href="#">Categoria Default</a></li>
				<li><span class="show-for-sr">Current: </span> ${product.title}</li>
			</ul>
		</nav>
	</div>

	<div class="row">
		<div class="medium-6 columns">
			<img class="thumbnail" src="http://placehold.it/650x350">
			<div class="row small-up-4">
				<div class="column">
					<img class="thumbnail" src="http://placehold.it/250x200">
				</div>
				<div class="column">
					<img class="thumbnail" src="http://placehold.it/250x200">
				</div>
				<div class="column">
					<img class="thumbnail" src="http://placehold.it/250x200">
				</div>
				<div class="column">
					<img class="thumbnail" src="http://placehold.it/250x200">
				</div>
			</div>
		</div>
		<div class="medium-6 large-5 columns">
			<form action="<c:url value="/shopping"/>" method="post">
			   	<input type="hidden" value="${product.id}" name="productId"/>
				<h3>${product.title}<small> (Páginas: ${product.pages})</small></h3>
				<hr>
				<p>${product.description}<br>
					<i>Veja o <a href="<c:url value='/${product.summaryPath}'/>" target="_blank">sum&#225;rio</a> completo do livro!</i>
				</p>
				<hr>
				<label>Formato 
					<select name="bookType">
						<c:forEach items="${product.prices}" var="price">
							<option value="${price.bookType}">${price.bookType} (R$ ${price.value})</option>
						</c:forEach>
					</select>
				</label>
				<div class="row">
					<div class="small-3 columns">
						<label for="middle-label" class="middle">Quantidade</label>
					</div>
					<div class="small-9 columns">
						<input type="text" id="middle-label" placeholder="Quantidade Exemplares" name="quantity">
					</div>
				</div>
				<input type="submit" class="button large expanded" value="Comprar Agora!" />
			</form>
		</div>
	</div>

	<div class="column row">
		<hr>
		<ul class="tabs" data-tabs id="example-tabs">
			<li class="tabs-title is-active"><a href="#panel1"
				aria-selected="true">Depoimentos</a></li>
			<li class="tabs-title"><a href="#panel2">Produtos Similares</a></li>
		</ul>
		<div class="tabs-content" data-tabs-content="example-tabs">
			<div class="tabs-panel is-active" id="panel1">
				<h4>Revisões</h4>
				<div class="media-object stack-for-small">
					<div class="media-object-section">
						<img class="thumbnail" src="http://placehold.it/200x200">
					</div>
					<div class="media-object-section">
						<h5>Mike Stevenson</h5>
						<p>I'm going to improvise. Listen, there's something you
							should know about me... about inception. An idea is like a virus,
							resilient, highly contagious. The smallest seed of an idea can
							grow. It can grow to define or destroy you.</p>
					</div>
				</div>
				<label> Minha Revisão 
					<textarea placeholder="..."></textarea>
				</label>
				<button class="button">Enviar Revisão</button>
			</div>
			<div class="tabs-panel" id="panel2">
				<div class="row medium-up-3 large-up-5">
					<div class="column">
						<img class="thumbnail" src="http://placehold.it/350x200">
						<h5>
							Other Product <small>$22</small>
						</h5>
						<p>In condimentum facilisis porta. Sed nec diam eu diam mattis
							viverra. Nulla fringilla, orci ac euismod semper, magna diam.</p>
						<a href="#" class="button hollow tiny expanded">Buy Now</a>
					</div>
					<div class="column">
						<img class="thumbnail" src="http://placehold.it/350x200">
						<h5>
							Other Product <small>$22</small>
						</h5>
						<p>In condimentum facilisis porta. Sed nec diam eu diam mattis
							viverra. Nulla fringilla, orci ac euismod semper, magna diam.</p>
						<a href="#" class="button hollow tiny expanded">Buy Now</a>
					</div>
					<div class="column">
						<img class="thumbnail" src="http://placehold.it/350x200">
						<h5>
							Other Product <small>$22</small>
						</h5>
						<p>In condimentum facilisis porta. Sed nec diam eu diam mattis
							viverra. Nulla fringilla, orci ac euismod semper, magna diam.</p>
						<a href="#" class="button hollow tiny expanded">Buy Now</a>
					</div>
					<div class="column">
						<img class="thumbnail" src="http://placehold.it/350x200">
						<h5>
							Other Product <small>$22</small>
						</h5>
						<p>In condimentum facilisis porta. Sed nec diam eu diam mattis
							viverra. Nulla fringilla, orci ac euismod semper, magna diam.</p>
						<a href="#" class="button hollow tiny expanded">Buy Now</a>
					</div>
					<div class="column">
						<img class="thumbnail" src="http://placehold.it/350x200">
						<h5>
							Other Product <small>$22</small>
						</h5>
						<p>In condimentum facilisis porta. Sed nec diam eu diam mattis
							viverra. Nulla fringilla, orci ac euismod semper, magna diam.</p>
						<a href="#" class="button hollow tiny expanded">Buy Now</a>
					</div>
				</div>
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
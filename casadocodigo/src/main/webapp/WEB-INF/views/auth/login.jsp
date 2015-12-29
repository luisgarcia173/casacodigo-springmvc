<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="http://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<title>login Page</title>
<style type="text/css">
	body {
	  background: #F0F0F4;
	}
	.login-box {
	  background: #fff;
	  border: 1px solid #ddd; 
	  margin: 100px 0;
	  padding: 40px 20px 0 20px;
	}
	.error {
		padding: 15px;
		margin-bottom: 20px;
		border: 1px solid transparent;
		border-radius: 4px;
		color: #a94442;
		background-color: #f2dede;
		border-color: #ebccd1;
	}
	.msg {
		padding: 15px;
		margin-bottom: 20px;
		border: 1px solid transparent;
		border-radius: 4px;
		color: #31708f;
		background-color: #d9edf7;
		border-color: #bce8f1;
	}
</style>
</head>
<body>

	<div class="large-4 large-centered columns">
		<div class="login-box">
			<div class="row">
				<div class="large-12 columns">
					<form:form servletRelativeAction="/login">
						<div class="row">
							<div class="large-12 columns">
								<h5>Login with Username/Password</h5>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<c:if test="${not empty error}">
									<div class="error">${error}</div>
								</c:if>
								<c:if test="${not empty msg}">
									<div class="msg">${msg}</div>
								</c:if>
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<input type="text" name="username" placeholder="Username" />
							</div>
						</div>
						<div class="row">
							<div class="large-12 columns">
								<input type="password" name="password" placeholder="Password" />
							</div>
						</div>
						<div class="row text-center">
							<div class="large-12 large-centered columns">
								<input type="submit" class="button expand" value="Log In" />
							</div>
						</div>
						<security:csrfInput/>
					</form:form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="http://dhbhdrzi4tiry.cloudfront.net/cdn/sites/foundation.js"></script>
	<script> $(document).foundation(); </script>
</body>
</html>
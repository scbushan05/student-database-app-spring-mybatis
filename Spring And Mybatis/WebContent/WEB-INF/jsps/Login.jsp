<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link type = "text/css" 
		rel = "stylesheet" 
		href = "${pageContext.request.contextPath}/images/bootstrap.min.css" />
<link type = "text/css" 
		rel = "stylesheet" 
		href = "${pageContext.request.contextPath}/images/jquery-ui.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body style = "background-color:#ffffcc;">
	<h1 align = "center">Login User</h1><br />
	<p align = "center">${wrong}</p>
	<div>
	<div class = "container" style = "padding-right: 15%;padding-left: 15%;">
		<form:form action = "loginProcess.html" onsubmit="return validateForm()" modelAttribute="student" name = "formCheck" class = "form-horizontal">
			
			<div class="form-group">	
				<label class = "control-label col-sm-4" for = "userName">Username*:</label>
				<div class="col-sm-4">
					<form:input path="userName" placeholder = "Enter Username" class="form-control" name = "userName" id="uname" />
				</div>
			</div>
			
			<div class="form-group">	
				<label class = "control-label col-sm-4" for = "password">Password*:</label>
				<div class="col-sm-4">
					<form:password path="password" placeholder = "Enter Password" class="form-control" name = "password" id="password"/>
				</div>
			</div>
			
			<div class = "form-group">
				<label class = "control-label col-sm-4"></label>
				<div class="col-sm-4">
					<button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-ok"></span> Login</button>
					<button type="reset" onclick = "document.forms['formCheck'].reset();" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-repeat"></span> Reset</button>
				</div>
			</div>
			
		</form:form>
	</div>
	</div>
<script type = "text/javascript"
		src = "${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/js/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function validateForm(){
		var username = document.formCheck.userName.value;
		var password = document.formCheck.password.value;
		
		if(username == null || username == ""){
			alert("Please enter username!");
			return false;
		}else if(password == null || password == ""){
			alert("Please enter password");
			return false;
		}
	}
	 
</script>
</body>
</html>
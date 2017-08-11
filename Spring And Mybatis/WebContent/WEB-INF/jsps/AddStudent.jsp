<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Customer</title>
<link type = "text/css" 
		rel = "stylesheet" 
		href = "${pageContext.request.contextPath}/images/bootstrap.min.css" />
<link type = "text/css" 
		rel = "stylesheet" 
		href = "${pageContext.request.contextPath}/images/jquery-ui.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();">
<div style = "padding-right: 5%;" class = "row">
	<div id = "wrapper">
		<div id = "header">
			<h2 align = "center">Employee Database App</h2>
		</div>
		<div id = "msgBlock" style = "padding-left: 10%;">	
			<c:if test="${not empty deleteMessage}">
				<div class="alert alert-danger alert-dismissable">
				<a class="close" data-dismiss="alert" aria-label="close" title="delete" onclick="close();">×</a>
					<strong>${deleteMessage}</strong>
				</div>
			</c:if>
		</div>
		<c:choose>
			<c:when test="${editBoolean==true}">
				<h3 align = "center">Update Employee</h3>
			</c:when>
			<c:otherwise>
				<h3 align = "center">Add Employee</h3>
			</c:otherwise>
		</c:choose>	
	</div>
	<p align = "right">
		<button class="btn btn-default btn-sm" 
				onclick="window.location.href='list.html'; return false;">
				<span class="glyphicon glyphicon-arrow-left"></span> Return to home page</button>
		<button class="btn btn-default btn-sm"
				onclick="window.location.href='logout.html'; return false;">
				<span class="glyphicon glyphicon-off"></span> Logout</button>
	</p>
	<div id = "container" class = "col-lg-8">
		
		<form:form action = "saveProcess.html" modelAttribute="student" name="formCheck" class = "form-horizontal" id = "reset" onsubmit="return validateform();">
			
			<form:hidden path="id" />

			<div class="form-group">	
				<label class = "control-label col-sm-2" for = "userName">User Name*:</label>
				<div class="col-sm-10">
					<form:input path="userName" onblur="$(this).ajaxCallForUsername();" placeholder = "Enter Username" class="form-control" name = "userName" id="uname" />
				</div>
			</div>
			
			<div class="form-group">	
				<label class = "control-label col-sm-2" for = "firstName">First Name*:</label>
				<div class="col-sm-10">
					<form:input path="firstName" placeholder = "Enter Firstname" class="form-control" name = "firstName" id="fname"/>
				</div>
			</div>
			
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "lastName">Last Name*:</label>
				<div class="col-sm-10">
					<form:input path="lastName" placeholder = "Enter Lastname" class="form-control" name = "lastName" id="lname"/>
				</div>
			</div>
			
			<form:hidden path="hobbies" id = "hobbies" />
			<form:hidden path="gender" id = "gender" />
			<form:hidden path="city" id = "city" />
			<form:hidden path="" value="${student.skills}" id = "skills"/>
					
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "dob">Date of birth*:</label>
				<div class="col-sm-10">
					<form:input path="dateOfBirth" placeholder = "Enter Dateofbirth" id="datepicker" class="form-control" name = "dateOfBirth" />
				</div>
			</div>
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "gender">Gender*:</label>
				<div class="col-sm-10">
					<label class="radio-inline"><form:radiobutton path="gender" id="gen" value="Male" name = "gender"/>Male</label>
					<label class="radio-inline"><form:radiobutton path="gender" id="gen" value="Female" name = "gender"/>Female</label>
				</div>
			</div>
			
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "hobbies">Hobbies:</label>
				<div class="col-sm-10">
					<label class="checkbox-inline"><form:checkbox path="hobbies" value = "Cricket" name = "hobbies"/>Cricket</label>
					<label class="checkbox-inline"><form:checkbox path="hobbies" value = "Football" name = "hobbies"/>Football</label>
					<label class="checkbox-inline"><form:checkbox path="hobbies" value = "Hockey" name = "hobbies"/>Hockey</label>
					<label class="checkbox-inline"><form:checkbox path="hobbies" value = "Volleyball" name = "hobbies"/>Volleyball</label>
				</div>
			</div>
			
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "dept">Department*:</label>
				<div class="col-sm-10">
					<form:select path="department.id" id="dept" name = "dept" class="form-control">
						<form:option value="0">Select</form:option>
						<c:forEach items="${deptList}" var="dept">
			 				<form:option value="${dept.id}">${dept.deptValue}</form:option>
			  			</c:forEach>
					</form:select>
				</div>
			</div>
			
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "dept">Skills*:</label>
				<div class="col-sm-10">
					<form:select path="skills" id="skillset" multiple="multiple" name = "skills" class="form-control">
						<form:option value="0"><b>Select</b></form:option>
						<c:forEach items="${skills}" var="s">
			 				<form:option value="${s.value}" name = "skills">${s.text}</form:option>
			  			</c:forEach>
					</form:select>
				</div>
			</div>
			
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "state">State*:</label>
				<div class="col-sm-10">
					<form:select path="state" id="state" name = "state" class="form-control" onchange="$(this).ajaxCallForCity();">
						<form:option value="0">Select</form:option>
						<c:forEach items="${stateList}" var="state">
			 				<form:option value="${state.value}">${state.text}</form:option>
			  			</c:forEach>
					</form:select>
				</div>
			</div>
			
<c:choose>
	<c:when test="${changed==true}">
   		<div class="form-group">
   			<label class = "control-label col-sm-2" for = "city">City*:</label>
   			<div class="col-sm-10">
	   			<form:select path="city" name = "city" class="form-control" id="citydropdown">
	   			<option value="">Select</option>
	     		<c:if test="${not empty setComboValues}">
	     			<c:forEach items="${setComboValues}" var="sp">
	     				<form:option value="${sp.key}">${sp.value}</form:option>
	     			</c:forEach>
	     		</c:if>
	     		</form:select>
     		</div>
  		</div>
	</c:when>
<c:otherwise>
	<div class="form-group">
		<label class = "control-label col-sm-2" for = "city">City*:</label>
	    <div class="col-sm-10">
		    <form:select path="city" name = "city" class="form-control" id="citydropdown">
		    <option value="">Select</option>  
		    <c:if test="${not empty setComboValues}">
		    	<c:forEach items="${setComboValues}" var="sp">
		     		<form:option value="${sp.key}">${sp.value}</form:option>
		     	</c:forEach>
		    </c:if>  
			</form:select>
		</div>
	</div>
</c:otherwise>
</c:choose>			
			<div class="form-group">
				<label class = "control-label col-sm-2" for = "email">Email*:</label>
				<div class="col-sm-10">
					<form:input path="email" placeholder = "Enter Email" class="form-control" name = "email" id="email"/>
				</div>
			</div>
			
			<c:choose>
				<c:when test="${not empty student.id}">
					<form:hidden path="reset" id = "hiddenPass" value = "${student.password}"/>
					<div class="form-group">	
						<label class = "control-label col-sm-2" for = "resetPass">Reset Password:</label>
						<div class="col-sm-10">
							<label class="checkbox-inline"><form:checkbox path="password" value = "${student.userName}" name = "resetPass" id = "resetPass"/></label>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="form-group">	
						<label class = "control-label col-sm-2" for = "password">Password*:</label>
						<div class="col-sm-10">
							<form:password path="password" placeholder = "Enter Password" class="form-control" name = "password" id="password"/>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			
			<div class = "form-group">
				<label class = "control-label col-sm-2"></label>
				<div class="col-sm-10">
					<button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-floppy-disk"></span> Save</button>
					<button type="reset" class="btn btn-default btn-sm" onclick="window.location.href='displayAddForm.html'; return false;"><span class="glyphicon glyphicon-repeat"></span> Reset</button>
				</div>
			</div>
			
		</form:form>
		<div style = "clear; both;"></div>
	</div>
</div>
<script type = "text/javascript"
		src = "${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/js/jquery-ui.js"></script>
<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
		<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/images/AddStudent.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type = "text/javascript">
$(document).ready(function(){
	var hobbies = $("#hobbies").val().split(",");
	var $checkboxes = $("input[type=checkbox]");
	$checkboxes.each(function(idx, element){
	if(hobbies.indexOf(element.value) != -1){
	    element.setAttribute("checked", "checked");
	    $("#hobbies").val("");
	}
	else{
	    element.removeAttribute("checked");
	    $("#hobbies").val("");
	}
		
	var gender = $("#gender").val();
	if($("#gender").val() != ''){
		var gen1 = gender.split(",");
		$("#gen").val(gen1).change();
		$("#gender").val("");
	}

	var city = $("#city").val();
	if($("#city").val() != ''){
		var gen2 = city.split(",");
		$("#citydropdown").val(gen2).change();
		$("#city").val("");
	}
	
	var skills = $("#skills").val().split(",");
	$('#skillset').val(skills);
	
	});
	(function($){
	$.fn.ajaxCallForUsername=function()
	{
		$.ajax({
			type : "POST",
			url : "checkUsername.html",
			data : ({
				"username" : $('#uname').val(),
			}),
			dataType : "json",
			success : function(response){
				if(response){
					alert("Username already exists");
				}
			},
		});
	};
	})(jQuery);
	$.fn.ajaxCallForCity=function()
	{ 	
		$.ajax({
	      	 type : "POST",
	      	 url : "getCity.html",
	      	 data : ({
	      	 	"tableField" : $(this).val(),
	      	 }),
	      	 dataType : "json",
	      	 success : function(response) {
	      	 if(response!=null){
	      		$("#citydropdown").html("<option  value=''>Select</option>");
			 	$.each(response, function(key, element) {
					$("#citydropdown").append("<option  value="+key+">"+element+"</option>");
			 	});
	   	 	} 
	   	},
	 });
	};
	$("#datepicker").datepicker({
	    dateFormat:"dd-M-yy",
	    showWeek: true,
	    changeMonth : true,
    	changeYear : true
	});
	jQuery.validator.addMethod("letters", function(value, element) {
		return this.optional(element) || /^[a-z]+$/i.test(value);
	});
	$("form[name='formCheck']").validate({
	rules: {
	  userName: {
			required: true,
			minlength: 8,
			maxlength: 12
	  },
	  firstName: {
		  	required: true,
			minlength: 4,
			maxlength: 10,
			letters: true
	  },
	  lastName: {
		  	required: true,
			minlength: 4,
			maxlength: 6,
			letters: true
	  },
	  dateOfBirth: {
			required: true  
	  },
	  hobbies: {
		  	required: true
	  },
	  gender: {
		  	required: true
	  },
	  state: {
		  	required: true
	  },
	  city: {
		  	required: true
	  },
	  email: {
	    required: true,
	    email: true
	  },
	  skills: {
		    required: true
		  },
	},
	messages: {
	  userName: "Please enter valid username. min = 8 characters, max = 12 characters",
	  firstName: "Please enter valid firstname. min = 4 characters, max=10 characters and numbers not allowed",
	  lastName: "Please enter valid lastname. min = 4 characters, max = 6 characters and numbers not allowed",
	  email: "Please enter a valid email address",
	  hobbies: "Please select any hobby from the list",
	  gender: "Please select gender",
	  state: "Please select state",
	  city: "Please select city",
	  skills: "Please select any skill",
	},
	submitHandler: function(form) {
	  form.submit();
	}
	});
});
</script>
</body>
</html>
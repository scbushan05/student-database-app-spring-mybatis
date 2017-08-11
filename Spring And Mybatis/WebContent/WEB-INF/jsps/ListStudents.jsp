<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://displaytag.sf.net" prefix="display" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List of Students</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/images/bootstrap.min.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body style="margin-right: 10px;margin-left: 10px;" onload="noBack();" onpageshow="if (event.persisted) noBack();">
	<div id="wrapper">
		<div id="header">
			<h2>Employee Database App</h2>
		</div>
	</div>
	<div id = "msgBlock">	
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success alert-dismissable">
			<a class="close" data-dismiss="alert" aria-label="close" title = "success" onclick="close();">×</a>
				<strong>${successMessage}</strong>
			</div>
		</c:if>
		<c:if test="${not empty updateMessage}">
			<div class="alert alert-info alert-dismissable">
			<a class="close" data-dismiss="alert" aria-label="close" title = "update" onclick="close();">×</a>
				<strong>${updateMessage}</strong>
			</div>
		</c:if>
		<c:if test="${not empty deleteMessage}">
			<div class="alert alert-danger alert-dismissable">
			<a class="close" data-dismiss="alert" aria-label="close" title="delete" onclick="close();">×</a>
				<strong>${deleteMessage}</strong>
			</div>
		</c:if>
		</div>
	<p align = "right">
	<button class="btn btn-default btn-sm"
				onclick="window.location.href='logout.html'; return false;"><span class="glyphicon glyphicon-off"></span> Logout</button></p>
	<div>
		<s:form action="searchProcess.html" modelAttribute="student" class="form-inline">
			<div class="form-group">
				<label for="filter">Filter By:</label>
				<s:select path = "search" id="country" title = "filter" class="form-control" onchange="$(this).ajaxCallForCity();">
					<s:option value="0">Select</s:option>
					<s:option value="Gender">Gender</s:option>
					<s:option value="Hobbies">Hobbies</s:option>
					<s:option value="State">State</s:option>
				</s:select>
			</div>
<c:choose>
	<c:when test="${changed==true}">
   		<div class="form-group">
   			<s:select path="secSearch" name = "city" class="form-control" id="citydropdown">
   			<option value="">Select</option>
     		<c:if test="${not empty setComboValues}">
     			<c:forEach items="${setComboValues}" var="sp">
     				<s:option value="${sp.key}">${sp.value}</s:option>
     			</c:forEach>
     		</c:if>
     		</s:select>
  		</div>
	</c:when>
<c:otherwise>
	<div class="form-group">
	    <s:select path="secSearch" name = "city" class="form-control" id="citydropdown">
			<option value="">Select</option>  
			<c:if test="${not empty setComboValues}">
				<c:forEach items="${setComboValues}" var="sp">
			    	<s:option value="${sp.key}">${sp.value}</s:option>
			    </c:forEach>
			</c:if>  
		</s:select>
	</div>
</c:otherwise>
</c:choose>			
    		<button type = "submit" value = "Go" class="btn btn-default btn-sm">Go <span class="glyphicon glyphicon-search"></span> </button>
		</s:form>
	</div><br />
		
		<c:set var="count" value="0" scope="page" />
		<display:table export="true" name="theStudents" requestURI="/student/list" pagesize="5" class="table table-bordered table-striped">
			
			<display:column title="Id" sortable="true" media="html">	
				<a href="javascript:$(this).ajaxfindById(${theStudents[count].id});">${theStudents[count].id}</a>
			</display:column>
			<display:column property="userName" title="Username" sortable="true" />
	        <display:column property="firstName" title="First Name" sortable="true" />
	        <display:column property="lastName" title="Last Name" sortable="true" />
	        <display:column property="email" title="Email" sortable="true" />
	        <display:column property="dateOfBirth" title="Date Of Birth" sortable="true" />	        
	        <display:column property="gender" title="Gender" sortable="true"  />	        
	        <display:column property="hobbies" title="Hobbies" sortable="true"  />	        
	        <display:column property="state" title="State" sortable="true"  />	
	        <display:column property="city" title="City" sortable="true"  />
	        <display:column property="deptValue" title="Department" sortable="true"  />
	        <display:column property="skills" title="Skills" sortable="true"  />	
	        
	        <display:setProperty name="export.pdf.students" value="theStudents.pdf"/>
	        <display:setProperty name="export.excel.students" value="theStudents.xls" />
	        <display:setProperty name="export.rtf.students" value="theStudents.rtf" />
	        <display:setProperty name="export.csv.students" value="theStudents.csv" />
	        <display:setProperty name="export.xml.students" value="theStudents.xml" />
	        <display:column title="Actions" media="html">
		        <c:url var = "updateLink" value = "/student/displayUpdateForm">
					<c:param name = "studentId" value="${theStudents[count].id}"/>
				</c:url>
				<c:url var = "deleteLink" value = "/student/displayDeleteForm">
					<c:param name = "studentId" value = "${theStudents[count].id}" />
				</c:url>
	        	<a href = "${updateLink}"><span class="glyphicon glyphicon-pencil"></span></a>
	        	|
	       	 	<a href = "${deleteLink}" 
				onclick = "if(!(confirm('Are you sure want to delete this customer?'))) return false"><span class="glyphicon glyphicon-remove"></span></a>
	        </display:column>
	    	<c:set var="count" value="${count + 1}" scope="page"/>
	    	
	    </display:table>
	    
	   	<button class="btn btn-default btn-sm"
				onclick="window.location.href='displayAddForm.html'; return false;"><span class="glyphicon glyphicon-user"></span> Add Employee</button>
		<br />
		<div id = "dialog-2" title = "Dialog Title goes here...">
        </div>
	
<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/js/jquery-3.1.1.min.js"></script>
<script type = "text/javascript"
		src = "${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
<script type = "text/javascript"
		src = "${pageContext.request.contextPath}/js/ListStudents.js"></script>
<script type = "text/javascript" 
		src = "${pageContext.request.contextPath}/js/jquery-ui.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
$('document').ready(function(){
	
	//ajax call for cascading drop down list of city based on state
	$.fn.ajaxCallForCity=function()
	{ 	
		$.ajax({
	      	 type : "POST",
	      	 url : "getSearchDropDown.html",
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
	};//ends here
	
	//ajax call for dialog box
	$.fn.ajaxfindById=function(a){
		 $.ajax({
	      	 type : "POST",
	      	 url : "findById.html",
	      	 data : ({
	      	 	"studentId" : a,
	      	 }),
	      	 dataType : "json",
	      	 success : function(response) {
	      	 if(response!=null){
	      		$("#dialog-2").html("<table class='table'><tr><th>Username:</th><td>&nbsp;"+response.userName+"</td></tr>"+
	      				"<tr><th>First Name:</th><td>&nbsp;"+response.firstName+"</td></tr>"+
	      				"<tr><th>Last Name:</th><td>&nbsp;"+response.lastName+"</td></tr>"+
	      				"<tr><th>Email:</th><td>&nbsp;"+response.email+"</td></tr>"+
	      				"<tr><th>Date Of Birth:</th><td>&nbsp;"+response.dateOfBirth+"</td></tr>"+
	      				"<tr><th>Gender:</th><td>&nbsp;"+response.gender+"</td></tr>"+
	      				"<tr><th>Hobbies:</th><td>&nbsp;"+response.hobbies+"</td></tr>"+
	      				"<tr><th>State:</th><td>&nbsp;"+response.state+"</td></tr>"+
	      				"<tr><th>City:</th><td>&nbsp;"+response.city+"</td></tr>"+
	      				"<tr><th>Skills:</th><td>&nbsp;"+response.skills+"</td></tr>"+
	      				"</table>")
	      		$("#dialog-2").dialog("open");
	   	 	} 
	   	},
	 });
	};//ends here
	
	$("#dialog-2").dialog({
        autoOpen: false, 
        buttons: {
           OK: function() {$(this).dialog("close");}
        },
        title: "Student Information",
        position: {
           my: "center",
           at: "center"
        }
     });
	
	if($('#citydropdown').val() != 0){
		$('#citydropdown').show();
		$('button[value = "Go"]').show();
	}else{
		$('#citydropdown').hide();
		$('button[value = "Go"]').hide();
	}
	$('#country').on('change', function(){
		$('#citydropdown').show();
		$('button[value = "Go"]').show();
	});
});
</script>
</body>
</html>
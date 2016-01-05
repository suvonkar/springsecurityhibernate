<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page session="true"%>
<html>
<head>
<title>Login Page</title>
<style>
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

#login-box {
	width: 300px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}
</style>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	function postAjaxCall(url, dataObj, dataType, contentType) {
		var headers = {};

		/* var csrfHeader = $("meta[name='_csrf_header']").attr("content");
		var csrfToken = $("meta[name='_csrf']").attr("content");
		headers[csrfHeader] = csrfToken; */
		
		var csrfHeader = $('#_csrf').attr('name');
		var csrfToken = $("#_csrf").val();
		headers[csrfHeader] = csrfToken;

		var returnObj;
		
		$.ajax({
			url : url,
			method : "POST",
			data : dataObj,
			dataType : dataType,
			contentType : contentType,
			async : false,
			headers : headers,
			success : function(result, status, jqXHR) {
				console.log("jqXHR" , jqXHR.getAllResponseHeaders());
				returnObj = result;
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log("Error : " + errorThrown);
				console.log("jqXHR" , jqXHR.getAllResponseHeaders());
				returnObj = jqXHR.responseJSON;
			}
		});
		
		return returnObj;
	};
	

	$(document).ready(function() {
		$("#login").click(function() {
			/* var data = {username : $('#username').val(), password : $('#password').val() };
			var csrfParameter = $("meta[name='_csrf.parameterName']").attr("content");
			var csrfToken = $("meta[name='_csrf']").attr("content"); 

			//data.username = $('#username').val();
			//data.password = $('#password').val();
			data.csrfParameter = csrfToken; */

			var returnObj = postAjaxCall("login/j_spring_security_check?username=" + $('#username').val() + "&password=" + $('#password').val(), {}, "json", "application/json; charset=utf-8");
			//var returnObj = postAjaxCall("login/j_spring_security_check", $('#loginForm').serialize(), "html", "application/json; charset=utf-8");
			$('#loginForm').html(returnObj);
		});

	});
</script>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<meta name="_csrf.parameterName" content="${_csrf.parameterName}" />
</head>
<body onload='document.loginForm.username.focus();'>

	<h1>Spring Security Login Form (Database + Hibernate
		Authentication)</h1>

	<div id="login-box">

		<h3>Login with Username and Password</h3>

		<c:if test="${not empty error}">
			<div class="error">${error}</div>
		</c:if>
		<c:if test="${not empty msg}">
			<div class="msg">${msg}</div>
		</c:if>

		<form id="loginForm" name='loginForm'
			action="<c:url value='/login/j_spring_security_check' />"
			method='POST'>

			<table>
				<tr>
					<td>User:</td>
					<td><input type='text' name='username' id="username"></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type='password' name='password' id="password" /></td>
				</tr>
				<tr>
					<td colspan='2'><input id="login" name="submit" type="button"
						value="submit" /></td>
				</tr>
			</table>

			<input type="hidden" id="_csrf" name="${_csrf.headerName}"
				value="${_csrf.token}" />

		</form>
	</div>

</body>
</html>
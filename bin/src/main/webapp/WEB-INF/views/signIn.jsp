<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign In</title>
</head>
<body>
	<mytags:navbar/>
	<h2>Please enter user credentials</h2>
	<form:form method="POST" action="SignInUser" modelAttribute="user">
		<table>
			<tr>
				<td><form:label path="userName">Username:</form:label></td>
				<td><form:input path="userName"></form:input></td>
			</tr>
			<tr>
				<td><form:label path="password">Password:</form:label></td>
				<td><form:input path="password"></form:input></td>
			</tr>	
			<tr>
				<td><input type="submit" value="submit"/></td>
			</tr>
		</table>	
	</form:form>
</body>
</html>
<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" >
</head>

<!--  set navbar item as active depending on current page -->
<c:set var="currentURL" value="${requestScope['javax.servlet.forward.servlet_path']}"></c:set>
<c:if test="${currentURL.equals('/')}">
	<c:set var="activeLink" value="$('#navHome').addClass('active');"/>
</c:if>
<c:if test="${currentURL.equals('/List')}">
	<c:set var="activeLink" value="$('#navList').addClass('active');"/>
</c:if>
<c:if test="${currentURL.equals('/registration')}">
	<c:set var="activeLink" value="$('#navUserRegistration').addClass('active');"/>
</c:if>
<c:if test="${currentURL.equals('/login')}">
	<c:set var="activeLink" value="$('#navSignIn').addClass('active');"/>
</c:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	${activeLink}
});
</script>

<body>
	<nav class="navbar navbar-default">
  		<div class="container-fluid">
    		<div class="navbar-header">
    		    <c:if test="${not empty user.userName}">
					<a class="navbar-branch href="#">Welcome, ${user.userName}</a>
				</c:if>
    		</div>
    		<ul class="nav navbar-nav">
      			<li id="navHome"><a href="/App">Home</a></li>
      			<li  id="navList"><a href="/">List</a></li>
      			<li id="navUserRegistration"><a href="/App/registration">Register</a></li>
    			<c:choose>
					<c:when test="${not empty user.userName}">
						<li id="navSignIn"><a href="/App/login" >Sign out</a></li>
					</c:when>
					<c:otherwise>
						<li id="navSignIn"><a href="/App/login">Sign In</a></li>		
					</c:otherwise>
				</c:choose> 
    		</ul>
  		</div>
	</nav>
  </body>
</html>
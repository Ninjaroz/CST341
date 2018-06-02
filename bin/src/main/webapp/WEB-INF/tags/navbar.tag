<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
  <%--<link href="${pageContext.request.contextPath}/resources/css/navbar.css" rel="stylesheet" >--%>
</head>

<!--  set navbar item as active depending on current page -->
<c:set var="currentURL" value="${requestScope['javax.servlet.forward.servlet_path']}"></c:set>
<c:if test="${currentURL.equals('/')}">
	<c:set var="activeLink" value="$('#navHome').addClass('active');"/>
</c:if>
<c:if test="${currentURL.equals('/List')}">
	<c:set var="activeLink" value="$('#navList').addClass('active');"/>
</c:if>
<c:if test="${currentURL.equals('/userRegistration')}">
	<c:set var="activeLink" value="$('#navUserRegistration').addClass('active');"/>
</c:if>
<c:if test="${currentURL.equals('/SignIn')}">
	<c:set var="activeLink" value="$('#navSignIn').addClass('active');"/>
</c:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	${activeLink}
});
</script>

<body>
	<div class="topNav">
		<c:if test="${not empty user.userName}">
			<a>Welcome, ${user.userName}</a>
		</c:if>
      	<a href="<c:url value="/"/>">Home</a>
      	<a href="<c:url value="/welcome"/>">List</a>
      	<a href="<c:url value="/registration"/>" style="float:right;">Register</a>
      	<c:choose>
			<c:when test="${not empty user.userName}">
				<a href="<c:url value="/login"/>" style="float:right;">Sign out</a>
			</c:when>
			<c:otherwise>
				<a href="<c:url value="/login?logout"/>" style="float:right;">Sign In</a>
			</c:otherwise>
		</c:choose> 
    </div>
  </body>
</html>
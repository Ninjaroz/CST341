<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="mytags" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<mytags:navbar/>
<body>
<h1>
	<c:choose>
		<c:when test="${not empty user.userName}">
		Hello, ${user.userName}
		</c:when>
		<c:otherwise>
		Hello world!		
		</c:otherwise>
	</c:choose>  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>

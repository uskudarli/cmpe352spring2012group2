<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Logout</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MyStyle.css">
</head>
<body>
	<%session.invalidate();%>
	<br><br><p>You have successfully logged out.</p>
	<br><br><a href="index.jsp">Return to Home Page</a>
</body>
</html>
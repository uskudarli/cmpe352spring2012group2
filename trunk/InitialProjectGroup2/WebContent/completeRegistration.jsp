<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MyStyle.css">
<title>Complete Registration</title>
</head>
<body>
<div id="header" style="background-color:#333;">
	<h1 style="padding: 10px;color:#FFF;">Welcome to the Social Service Exchange Platform</h1></div><br><br>
	<form action="Complete.jsp" method="post" id="login">
	<div  style="margin:auto">
		<b>Please provide necessary information to finish your registration.</b>
	<%
		if(session.getAttribute("name").equals("NULL)"))
			%>
				<br><b>Name</b><input type="text" name="name">
				
			<%
		if(session.getAttribute("surname").equals("NULL)"))
			%>
				<br><b>Surname</b><input type="text" name="surname">		
			<%
		if(session.getAttribute("phone").equals("NULL)"))
			%>
				<br><b>Mobile Phone</b><input type="text" name="phone">		
			<%
			
		if(session.getAttribute("about").equals(" "))			
			%>
				<br><b>About Me</b><textarea cols="30" rows="5" name="about">	</textarea>
				<br><input type="submit" value="Send" class="button" style="margin:auto">	
		
	</div>
	</form>
	<br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MyStyle.css">
</head>
<body style="background-color:#EEEEEE;">
<div id="header" style="background-color:#333;">
	<h1 style="margin-bottom:0;color:#FFF;">Welcome to the Social Service Exchange Platform</h1></div>
	<form action="profile.jsp" method="post">
				
				<div class="center">
				<p>Note that create account will be implemented later.</p>
				<br><b>Username</b>
				<input type="text" name="username" value="email@email.com" maxlength=25 align="right">	
			
				<br><b>Password</b>
				<input type="password" name="password" value="myPassword" maxlength=25 align="right">
		
			
				<br><input type="submit" value="NextPage" class="button">		
		
		<p> <b>Sample Username:</b> email@email.com <br> <b>Sample Password:</b> myPassword </p></div>
			
	</form>
	
<br><br><hr><div id="footer"><p>Copyright � Boun Cmpe451 - Group 2</p></div>
	
<!--  <hr><div id="footer" style="background-color:#FFA500;clear:both;text-align:center;">
Copyright � Boun Cmpe451 - Group 2</div> -->
</body>
</html>
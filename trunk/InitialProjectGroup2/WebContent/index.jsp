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
	<h1 style="padding: 10px;color:#FFF;">Welcome to the Social Service Exchange Platform</h1></div><br><br>
	<table border = "0">
	<tr>
	<td width="60%">
	<form action="profile.jsp" method="post" id="login">
			<div class="center">	
				<h2>Login</h2>
				<br><b>Username</b>
				<input type="text" name="username" value="einstein@physicist.com" maxlength=25 align="right">	
			
				<br><b>Password&nbsp;</b>
				<input type="password" name="password" value="myPassword" maxlength=25 align="right">
		
			
				<br><input type="submit" value="Login" class="button" style="margin:auto">		
		
		<p> <b>Sample Username:</b> email@email.com <br> <b>Sample Password:</b> myPassword </p></div>
			
	</form></td>
	<td>
	<form action="register.jsp" method="post" id="registration">
		<div class="center">
			<h2>Sign Up</h2>
			<br><b>Type e-mail address&nbsp;</b>
			<input type="text" name="username"  maxlength=25 align="right">	
			
			
			<br><b>Password&nbsp;</b>
			<input type="password" name="password" maxlength=25 align="right">
			<br><b> Re-Type Password&nbsp;</b>
			<input type="password" name="re-password" maxlength=25 align="right">
			<br>
			<input type="submit" method="post" value="Register" class="button" style="margin:auto">
		</div>
		
	</form></td></tr>
	</table>
	
<br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
	
<!--  <hr><div id="footer" style="background-color:#FFA500;clear:both;text-align:center;">
Copyright © Boun Cmpe451 - Group 2</div> -->
</body>
</html>
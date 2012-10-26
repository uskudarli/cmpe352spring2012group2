<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<body>
	<form action="profile.jsp" method="post">
		<p>Welcome! Create account will be implemented later</p>
		<ul>
			<li>
				<b>Username</b>
				<input type="text" name="username" value="" maxlength=25 align="right">
			
			</li>
			<li>
				<b>Password</b>
				<input type="password" name="password" value="" maxlength=25 align="right">
			</li>
			<li>
				<input type="submit" value="NextPage">
			</li>
			
		</ul>
		<p> <b>Sample Username:</b> email@email.com <br> <b>Sampe Password:</b> myPassword </p>
			
	</form>
</body>
</html>
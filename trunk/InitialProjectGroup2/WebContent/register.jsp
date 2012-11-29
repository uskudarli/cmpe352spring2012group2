<%@page import="com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException"%>
<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MyStyle.css">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Register Confirmation</title>
</head>
<body>
<div id="header" style="background-color:#333;">
	<h1 style="padding: 10px;color:#FFF;">Welcome to the Social Service Exchange Platform</h1></div><br><br>
	<% 
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String repassword = request.getParameter("re-password");
		if(username==null || username.equals("")){
			%>
			<div>
				<h1>Please provide an e-mail address.</h1>
				<br><br><a href="index.jsp">Return to Main Page.</a>
			</div> <% 
		}
		else if(password==null || password.equals("")){
			%>
			<div>
				<h1>Please provide a password.</h1>
				<br><br><a href="index.jsp">Return to Main Page.</a>
			</div> <% 
		}
		else if(!password.equals(repassword)){
			%>
			<div>
				<h1> Passwords mismatch.</h1>
				<br><br><a href="index.jsp">Return to Main Page.</a>
			</div> <% 
		}
		else{
		String registerQuery = "INSERT INTO User(email, password, aboutMe) VALUES ('"+username+"', '"+password+"', ' ')";
		DBConnection dbConnection = new DBConnection();
		try{
			dbConnection.executeUpdate(registerQuery);%>
			<div>
				<h1> Registration Successful! </h1>
				<br><br><a href="index.jsp">Click here to Login.</a>
			</div> <% 
		}catch(MySQLIntegrityConstraintViolationException e1){
			%>
			<div>
				<h1>This e-mail is already in use!</h1>
			</div> <% 
		}catch(Exception e){
		%>
			<div>
				<h1> An Error Occured.</h1>
			</div> <% 
			
		}
		dbConnection.closeConnection();
		}
	%>
<br><br><hr><div id="footer"><p>Copyright Boun Cmpe451 - Group 2</p></div>	
</body>
</html>
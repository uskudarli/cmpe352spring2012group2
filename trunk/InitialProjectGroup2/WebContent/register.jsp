<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>
	<% 
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String registerQuery = "INSERT INTO User(email, password, aboutMe) VALUES ('"+username+"', '"+password+"', ' ')";
		DBConnection dbConnection = new DBConnection();
		try{
			dbConnection.executeUpdate(registerQuery);%>
			<div>
				<h1> Registration Successful</h1>
			</div> <% 
		}catch(Exception e){%>
			<div>
				<h1> AN Error Occured</h1>
			</div> <% 
			
		}
		dbConnection.closeConnection();
		
	%>
	
</body>
</html>
<%@page import="java.sql.SQLException"%>
<%@page import="com.group2.DBConnection"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Application Result</title>
</head>
<body>
<%
	String serviceId = request.getParameter("processId");
	String email = (String)session.getAttribute("email");
	String ins = "Insert Into Appliers (ServiceId,email) Values ("+serviceId+", '"+email+"')";
	DBConnection db = new DBConnection();
	try{
	
	db.executeUpdate(ins);
	%>
	Succesful! <%=serviceId %>
	<%
	}catch(SQLException e){
		e.printStackTrace();
		%>
		An error occured or you already applied for that service!
		<%
	}
	db.closeConnection();
%>
</body>
</html>
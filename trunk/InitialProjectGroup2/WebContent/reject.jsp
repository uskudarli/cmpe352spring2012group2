<%@page import="java.sql.ResultSet"%>
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
String applierId=request.getParameter("applierId");
String serviceId=request.getParameter("processId");
DBConnection db = new DBConnection();
	String ins = "Insert Into RejectedServices (ServiceId,email) Values ("+serviceId+", '"+applierId+"')";
	String delete = "Delete from Appliers where serviceId='"+serviceId+"' and email='"+applierId+"'";
	
	db.executeUpdate(ins);
	db.executeUpdate(delete);
%>
Reject Completed

</body>
</html>
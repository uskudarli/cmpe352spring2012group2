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
String st = "Select applierQuota from OpenServices Where serviceId='"+serviceId+"'";
int t=-1;
DBConnection db = new DBConnection();
ResultSet rs = db.executeQuery(st);
if(rs.next())
	t=rs.getInt(1);
if(t>0){
	t--;
	String ins = "Insert Into AcceptedServices (ServiceId,email) Values ("+serviceId+", '"+applierId+"')";
	String decrease = "Update OpenServices Set applierQuota='"+t+"' where serviceId='"+serviceId+"'";
	String delete = "Delete from Appliers where serviceId='"+serviceId+"' and email='"+applierId+"'";
	db.executeUpdate(ins);
	db.executeUpdate(decrease);
	db.executeUpdate(delete);
%>
Request Accepted
<%}
else
{
%>
Your Quota is Full!
<% } %>
</body>
</html>
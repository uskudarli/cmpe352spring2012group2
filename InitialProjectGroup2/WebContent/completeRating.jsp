<%@page import="java.sql.ResultSet"%>
<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Vote Result</title>
</head>
<body>
<%
DBConnection db = new DBConnection();
String query1 = request.getParameter("query1");
String query2 = request.getParameter("query2");
String serviceId = request.getParameter("serviceId");
String comment = request.getParameter("comment");
String rating = request.getParameter("rating");
String partnerId = request.getParameter("partnerId");
query1+="'"+comment+"' where serviceId = '"+serviceId+"'";
query2+="'"+rating+"' where serviceId = '"+serviceId+"'";
db.executeUpdate(query1);
db.executeUpdate(query2);


String query = "select rating, ratingCount from User where email = '"+partnerId+"'";
ResultSet rs = db.executeQuery(query);
rs.next();
float rate = rs.getFloat(1);
int numberOfRates = rs.getInt(2);
rate = (numberOfRates*rate+Float.parseFloat(rating))/(numberOfRates+1);
numberOfRates++;
query = "update User set rating = '"+rate+"' , ratingCount = '"+numberOfRates+"' where email = '"+partnerId+"'";
db.executeUpdate(query);



db.closeConnection();




%>
You have successfully voted this service.<br>
<a href="profile.jsp"><strong>&#8249;-- Return to Home </strong></a>

</body>
</html>
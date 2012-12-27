<%@page import="java.sql.ResultSet"%>
<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Service Rating</title>
</head>
<body>


<%
DBConnection db = new DBConnection();
String query="";
ResultSet rs;
String serviceId = request.getParameter("serviceId");
String partner = request.getParameter("applierId");
System.out.println("partnertim = "+partner);
String pageName = request.getParameter("pageName");

if(pageName.equals("showAppliers")){
	query = "select * from CompletedServices where (serviceId = "+serviceId+")";
	rs = db.executeQuery(query);
	rs.next();
	if(rs.getString(4) == null){
		%>
		<form  action="completeRating.jsp" method="post">
		Your rating for this service: <input type="number"  min="1" max="10" value="5" id="rating" name="rating" size="42"><br>
		Your comments for this service<br> 		
		<textarea rows="5" cols="30" name="comment"></textarea>
		<input type="hidden" name="query1" value="<%="update CompletedServices set comment = " %>">
		<input type="hidden" name="query2" value="<%="update CompletedServices set rating = " %>">
		<input type="hidden" name="serviceId" value=<%=serviceId %>>
		<input type="hidden" name="partnerId" value=<%=partner %>>
		<input type ="submit" value="Vote!" class="btn btn-primary">
		</form>
		<% 
	}else{
		%>You have already voted. <% 
	}
	
	
}else if(pageName.equals("serviceStatus")){
	query = "select * from CompletedServices where (serviceId = "+serviceId+")";
	rs = db.executeQuery(query);
	rs.next();
	if(rs.getString(6) == null){
		%>
		<form  action="completeRating.jsp" method="post">
		Your rating for this service: <input type="number"  min="1" max="10" value="5" id="rating" name="rating" size="42"><br>
		Your comments for this service<br> 		
		<textarea rows="5" cols="30" name="comment"></textarea>
		<input type="hidden" name="query1" value="<%="update CompletedServices set partnerComment = " %>">
		<input type="hidden" name="query2" value="<%="update CompletedServices set partnerRating = " %>">
		<input type="hidden" name="serviceId" value=<%=serviceId %>>
		<input type="hidden" name="partnerId" value=<%=partner %>>
		<input type ="submit" value="Vote!" class="btn btn-primary">
		</form>
		<% 
	}else{
		%>You have already voted. <% 
	}
}else{
	//error
}
db.closeConnection();
%>

</body>
</html>
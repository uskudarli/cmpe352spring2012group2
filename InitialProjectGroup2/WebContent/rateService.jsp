<%@page import="java.sql.ResultSet"%>
<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Service Rating</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MyStyleProfile.css">
</head>
<body>

<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class=""><a href="profile.jsp">Home</a></li>
              <li class=""><a href="createService.jsp">Offer a Service</a></li>
              <li class=""><a href="requestService.jsp">Request a Service</a></li>
              <li class=""><a href="searchPage.jsp">Search for a Service</a></li>
            </ul>
            <ul class="nav pull-right">
                  <li><a href="Logout.jsp">Logout</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
<br><br><br><br><br>


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
		<div class="rating_class">
		Your rating for this service: <br> <input type="number"  min="1" max="10" value="5" id="rating" name="rating" size="42"><br>
		Your comments for this service:<br> 		
		<textarea rows="5" cols="30" name="comment"></textarea>
		<input type="hidden" name="query1" value="<%="update CompletedServices set partnerComment = " %>">
		<input type="hidden" name="query2" value="<%="update CompletedServices set partnerRating = " %>">
		<input type="hidden" name="serviceId" value=<%=serviceId %>>
		<input type="hidden" name="partnerId" value=<%=partner %>>
		<br>
		<input type ="submit" value="Vote!" class="btn btn-primary">
		</div>
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

		<br><a href="serviceStatus.jsp"><strong>&#8249;-- Return to Service Status</strong></a>
		
		<hr><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>

</body>
</html>
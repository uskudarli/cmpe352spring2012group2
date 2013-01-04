<%@page import="java.sql.SQLException"%>
<%@page import="com.group2.DBConnection"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="./css/MyStyleProfile.css">
<title>Application Result</title>
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
	<br><br><br><br><br><br>
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

	<br><br><br><br><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
</body>
</html>
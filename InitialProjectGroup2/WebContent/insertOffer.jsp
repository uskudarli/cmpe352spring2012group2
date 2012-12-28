<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.sql.*" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Offer Result</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="./css/MyStyle.css">
</head>
<body>
<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class=""><a href="profile.jsp">Home</a></li>
              <li class=""><a href="profile.jsp">Profile</a></li>
              <li class=""><a href="searchPage.jsp">Search For a Service</a></li>
            </ul>
            <ul class="nav pull-right">
                  <li><a href="Logout.jsp">Logout</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
<br><br><br>
<%
 String email = session.getAttribute( "email" ).toString();

 String title = request.getParameter("title");
 String description = request.getParameter("description");
 String tags = request.getParameter("tags");
 String date_start = request.getParameter("date_start");
 String date_end = request.getParameter("date_end");
 String gpsLocation = request.getParameter("gpsLocation");
 String applierQuota = request.getParameter("applierQuota");
 
 String[] tagArray = tags.split(",");
 String[] locations = gpsLocation.split(";");
 
 
 try{
	 DBConnection db = new DBConnection();
 db.executeUpdate("insert into OpenServices(email,title,description,dateFrom,dateTo,demanderOrSupplier,applierQuota) values('"+email+"','"+title+"','"+description+"','"+date_start+"','"+date_end+"','supplier','"+applierQuota+"')  ");
 ResultSet rs=db.executeQuery("select serviceId from OpenServices where (email = '"+email+"' and title = '"+title+"')");
 boolean check = rs.next();
 if(check){
	 out.println("Service has been created");
 }else{
	 out.println("There is something wrong with the service creation");
 }
 int serviceId = rs.getInt(1);
 for(int i=0; i<tagArray.length; i++){
	 db.executeUpdate("insert into Tags values('"+serviceId+"','"+tagArray[i]+"')");
 }
 for(int i=0; i<locations.length; i++){
	 String[] detailedLocationInfo = locations[i].split("-");
	 db.executeUpdate("insert into Place values('"+serviceId+"','"+detailedLocationInfo[0]+"','"+detailedLocationInfo[1]+"','"+detailedLocationInfo[2]+"')");
 }
 db.closeConnection();
 }
 catch (Exception e){
 out.println(e.getMessage());
 }
 
 %>
</body>
</html>
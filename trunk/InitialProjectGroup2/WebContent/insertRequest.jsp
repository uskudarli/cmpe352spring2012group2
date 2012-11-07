<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.sql.*" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Offer Result</title>
</head>
<body>
<%
 String email = session.getAttribute( "email" ).toString();

 String title = request.getParameter("title");
 String description = request.getParameter("description");
 String tags = request.getParameter("tags");
 String date_start = request.getParameter("date_start");
 String date_end = request.getParameter("date_end");
 String gpsLocation = request.getParameter("gpsLocation");

 
 String[] tagArray = tags.split(",");
 String[] locations = gpsLocation.split(";");
 
 Connection con = null;
 String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";;
 String db = "database2";
 String driver = "com.mysql.jdbc.Driver";
 String userName ="project2";
 String password="G6v0W7";
 try{
 Class.forName(driver);
 con = DriverManager.getConnection(url+db,userName,password);
 Statement st = con.createStatement();
 st.executeUpdate("insert into OpenServices(email,title,description,dateFrom,dateTo,demanderOrSupplier) values('"+email+"','"+title+"','"+description+"','"+date_start+"','"+date_end+"','demander')  ");
 ResultSet rs=st.executeQuery("select serviceId from OpenServices where (email = '"+email+"' and title = '"+title+"')");
 boolean check = rs.next();
 if(check){
	 out.println("Service has been requested.");
 }else{
	 out.println("There is something wrong with the service request");
 }
 int serviceId = rs.getInt(1);
 for(int i=0; i<tagArray.length; i++){
	 st.executeUpdate("insert into Tags values('"+serviceId+"','"+tagArray[i]+"')");
 }
 for(int i=0; i<locations.length; i++){
	 String[] detailedLocationInfo = locations[i].split("-");
	 st.executeUpdate("insert into Place values('"+serviceId+"','"+detailedLocationInfo[0]+"','"+detailedLocationInfo[1]+"','"+detailedLocationInfo[2]+"')");
 }
 }
 catch (Exception e){
 out.println(e.getMessage());
 }
 
 %>
</body>
</html>
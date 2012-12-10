<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Show Appliers</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="./css/MyStyleProfile.css">
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
<h1>Show Appliers</h1><hr>
<%
String value = request.getParameter("value");
String email1 = session.getAttribute("email").toString();
int check=0;
Connection con = null;
String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
String db = "database2";
String driver = "com.mysql.jdbc.Driver";
String userName ="project2";
String password="G6v0W7";
try{
Class.forName(driver);
con = DriverManager.getConnection(url+db,userName,password);
try{
Statement st = con.createStatement();
Statement st1 = con.createStatement();

ResultSet rs=st.executeQuery("SELECT User.name, User.surname, User.email, Appliers.serviceId FROM User INNER JOIN Appliers ON User.email=Appliers.email WHERE Appliers.serviceId='"+value+"'");
	
ResultSet rs1= st1.executeQuery("SELECT email FROM OpenServices WHERE serviceID="+value);

String a="";
while(rs1.next()){
	a=rs1.getString(1);
}
if(a.equals(email1)){
	check=1;
}
boolean IsRowExist=rs.next();
if (IsRowExist){
	if(check==1){
%>

<div class="TableFormat">
<table border="3">
<tr>
<td colspan="2">Appliers</td>
</tr>
<tr>
<td>Name</td>
<td>Surname</td>
<td>Accept</td>
<td>Reject</td>
</tr>
<%
	}
}
rs.beforeFirst();
while(rs.next()) {
String name =rs.getString(1);
String surName=rs.getString(2);
String email=rs.getString(3);
	if(check==1){
%>
<tr>
<td><a href="applierProfile.jsp?qid=<%=email%>"><%=name %></a>
</td>
<td><%=surName %>
</td>
	
	<td><form action="accept.jsp" method="get">
	<input type="hidden" name="applierId" value=<%=email %>>
	<input type="hidden" name="processId" value=<%=value %>>
	
	<input type ="submit" value="Accept">
	</form>
	</td>
	<td><form action="reject.jsp" method="get">
	<input type="hidden" name="applierId" value=<%=email %>>
	<input type="hidden" name="processId" value=<%=value %>>
	
	<input type ="submit" value="Reject">
	</form>
	</td>
</tr>
<%
	}
}
rs.beforeFirst();
if (!rs.next())
{
	out.println("Nobody has applied for this service.");
}
}catch(Exception e1){
	e1.printStackTrace();
}
}
catch (Exception e){
e.printStackTrace();
}

if(check!=1){
%>
You are trying to access restricted area for you!
<%
}
%>
</table></div>
<hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
</body>
</html>
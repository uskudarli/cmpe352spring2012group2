<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Show Appliers</title>
<link rel="stylesheet" type="text/css" href="./css/MyStyleProfile.css">
</head>
<body>
<h1>Show Appliers</h1><hr>
<%
String value = request.getParameter("value");
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

ResultSet rs=st.executeQuery("SELECT User.name, User.surname, User.email, Appliers.serviceId FROM User INNER JOIN Appliers ON User.email=Appliers.email WHERE Appliers.serviceId='"+value+"'");

boolean IsRowExist=rs.next();
if (IsRowExist){
%><div class="TableFormat">
<table border="3">
<tr>
<td colspan="2">Appliers</td>
</tr>
<tr>
<td>Name</td>
<td>Surname</td>
</tr>
<%
}
rs.beforeFirst();
while(rs.next()) {
String name =rs.getString(1);
String surName=rs.getString(2);
String email=rs.getString(3);
%>

<tr>
<td><a href="applierProfile.jsp?qid=<%=email%>"><%=name %>
</td>
<td><%=surName %>
</td>
</tr>

<%
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

%>
</table></div>
<hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
</body>
</html>
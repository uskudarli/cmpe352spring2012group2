<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.sql.*" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>
<body>

<%
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
ResultSet rs=st.executeQuery("select * from User where (email = 'email@email.com')");
rs.next();
String mail =rs.getString(1);
String pass=rs.getString(2);
String name=rs.getString(3);
String surname=rs.getString(4);
String credit=rs.getString(5);
String rating=rs.getString(6);
String phone=rs.getString(7);
String about=rs.getString(8);

session.setAttribute( "email", mail );
session.setAttribute( "password", pass );
session.setAttribute( "name", name );
session.setAttribute( "surname", surname );
session.setAttribute( "credit", credit );
session.setAttribute( "rating", rating );
session.setAttribute( "phone", phone );

out.println("Welcome , "+name+" "+surname);
}
catch (Exception e){
e.printStackTrace();
}
session.setAttribute( "email", "email@email.com" );

%>
<br>
<a href="createService.jsp">Click Here to Create a Service</a>
<br>
<a href="OfferedServices.jsp">Click Here to See the Services That You Have Offered</a>
</body>
</html>
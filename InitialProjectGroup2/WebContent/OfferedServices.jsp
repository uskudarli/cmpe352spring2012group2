<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String email = session.getAttribute( "email" ).toString();
Connection con = null;
String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";;
String db = "database2";
String driver = "com.mysql.jdbc.Driver";
String userName ="project2";
String password="G6v0W7";
try{
Class.forName(driver);
con = DriverManager.getConnection(url+db,userName,password);
try{
Statement st = con.createStatement();

ResultSet rs=st.executeQuery("SELECT * FROM `OpenServices` WHERE email='"+email+"'");

while(rs.next()) {
String title =rs.getString(2);
String description=rs.getString(3);
String serviceId=rs.getString(4);
String dateFrom=rs.getString(5);
String dateTo=rs.getString(6);


out.println("title= "+title+"\ndescription = "+description+"\nserviceId = "+serviceId+"\ndateFrom = "+dateFrom+"\ndateTo = "+dateTo);

}
}catch(Exception e1){}
}
catch (Exception e){
e.printStackTrace();
}

%>
</body>
</html>
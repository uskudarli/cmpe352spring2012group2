<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="java.sql.*" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
ne bu ya
<%
out.println("geldim");
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

ResultSet rs=st.executeQuery("select * from User");

while(rs.next()) {
String mail =rs.getString(1);
String passwowd=rs.getString(2);
String name=rs.getString(3);
String surname=rs.getString(4);
String credit=rs.getString(5);
String rating=rs.getString(6);
String phone=rs.getString(7);
String about=rs.getString(8);

out.println("e-mail = "+mail+"\npassword = "+password+"\nname = "+name+"\nsurname = "+surname+"\ncredit = "+credit+"\nrating = "+rating+"\nphone = "+phone+"\nabout me ="+about);

}
}catch(Exception e1){}
}
catch (Exception e){
e.printStackTrace();
}

%>
</body>
</html>
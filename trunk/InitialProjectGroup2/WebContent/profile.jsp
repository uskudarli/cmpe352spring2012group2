<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile</title>
</head>
<body>
	<p>Next Page</p>
	<%
		String username=request.getParameter("username");
		String password = request.getParameter("password");
		
		Connection con= null;
		String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
		String db = "database2";
		String driver = "com.mysql.jdbc.Driver";
		String userName ="project2";
		String databasePassword="G6v0W7";
		try{
			Class.forName(driver);
			
			con = DriverManager.getConnection(url+db,userName,databasePassword);
			Statement st=con.createStatement();
			ResultSet rs= st.executeQuery("Select * from User where email='"+username+"'");
			if(rs.next() && rs.getString(2).equals(password) ){
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
				
				%>
					<ul>
						<li> <%=name+" "+surname %> </li>
						<li> <b>Social Credit: </b><%=credit %>
						<li> <b>Rating: </b><%=rating %>
						<li> <b>Mobile Phone:</b><%=phone %>
						<li> <b>Personal Information:</b><%=about%>
					
					
					</ul>
					<br>
						<a href="createService.jsp">Click Here to Create a Service</a>
					<br>
						<a href="requestService.jsp">Click Here to Request a Service</a>
					
					<br>
						<a href="OfferedServices.jsp">Click Here to See the Services That You Have Offered</a>
					
					
							
				<%
			}
			else
				out.print("Error! Wrong Username or Password ");
			
		
		}catch(Exception e){
			e.printStackTrace();
			out.print("Error! Wrong Username or Password ");
		};
		%>
</body>
</html>
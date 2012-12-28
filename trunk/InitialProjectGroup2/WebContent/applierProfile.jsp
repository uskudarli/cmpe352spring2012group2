<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Appliers Profile</title>
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
		String username = "";
		if(request.getParameter("qid")!=null)
			username = (request.getParameter("qid"));
		
		try{
			DBConnection db = new DBConnection();
			ResultSet rs= db.executeQuery("Select * from User where email='"+username+"'");
			if(rs.next()){
				
				String mail =rs.getString(1);
				//String pass=rs.getString(2);
				String name=rs.getString(3);
				String surname=rs.getString(4);
				String credit=rs.getString(5);
				String rating=rs.getString(6);
				String phone=rs.getString(7);
				String about=rs.getString(8);
				about = URLDecoder.decode(about,"UTF-8");
				/*session.setAttribute( "email", mail );
				session.setAttribute( "password", pass );
				session.setAttribute( "name", name );
				session.setAttribute( "surname", surname );
				session.setAttribute( "credit", credit );
				session.setAttribute( "rating", rating );
				session.setAttribute( "phone", phone );
				session.setAttribute( "about", about );
				*/
				if(name.equals("NULL"))
					request.getRequestDispatcher("completeRegistration.jsp").forward(request, response);
				%>
			
<h1><%=name+" "+surname%></h1>
<div id="wrapper">

					<!--  <p style="font-size:24px;"><b><%=name+" "+surname%></b></p> -->
					<ul>
						<!-- <li> <b><%=name+" "+surname %></b> -->
						<!--  <li> <b>Social Credit: </b><%=credit %> -->
						<!-- <li> <b>Rating: </b><%=rating %> -->
						<li> <b>Mobile Phone:</b><%=phone %>
						<li> <b>Personal Information:</b><%=about%>
					
					</ul>

</div>

<div id="extra">
<p style="font-size:21px;"><b>Social Credit:    <i><%=credit %></i><br>Rating:    <i><%=rating %></i></b></p>
</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
					
							
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
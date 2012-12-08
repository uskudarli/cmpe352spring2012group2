<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.SQLException"%>
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
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/MyStyleProfile.css">
</head>
<body>
	<%
		String username=request.getParameter("username");
		if(username==null)
			username=(String)request.getSession().getAttribute("email");
	
		String password = request.getParameter("password");
		if(password==null)
			password=(String)request.getSession().getAttribute("password");
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
				about = URLDecoder.decode(about,"UTF-8");
				session.setAttribute( "email", mail );
				session.setAttribute( "password", pass );
				session.setAttribute( "name", name );
				session.setAttribute( "surname", surname );
				session.setAttribute( "credit", credit );
				session.setAttribute( "rating", rating );
				session.setAttribute( "phone", phone );
				session.setAttribute( "about", about );
				
				if(name.equals("NULL"))
					request.getRequestDispatcher("completeRegistration.jsp").forward(request, response);
				%>
						
<!-- <div id="header"><h1>Header</h1></div> -->
<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <div class="nav-collapse collapse">
            <ul class="nav">
              <li class="active"><a href="#">Home</a></li>
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
			
<h1>Profile</h1>
<div id="wrapper">
<div id="content">
					<p style="font-size:24px;"><b>Hello <%=name+" "+surname%></b></p>
					<ul>
						<!-- <li> <b><%=name+" "+surname %></b> -->
						<!--  <li> <b>Social Credit: </b><%=credit %> -->
						<!-- <li> <b>Rating: </b><%=rating %> -->
						<li> <b>Mobile Phone:</b><%=phone %>
						<li> <b>Personal Information:</b><%=about%>
					
					</ul>
</div>
</div>

<div id="navigation">
<div id="menupane" class="menu">					
						<a href="createService.jsp">Create a Service</a>
						<a href="requestService.jsp">Request a Service</a>
						<a href="OfferedServices.jsp">Offered Services</a>
						<a href="requestedServices.jsp">Requested Services</a>
						<a href="serviceStatus.jsp">Service Status</a>												
					</div>
</div>


<div id="extra">
<p style="font-size:21px;"><b>Social Credit:    <i><%=credit %></i><br>Rating:    <i><%=rating %></i></b></p>
</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><hr><div id="footer"><p>Copyright � Boun Cmpe451 - Group 2</p></div>
					
							
				<%
			}
			else{
				%>
			<div>
				<h1 style="margin-left:2 em;font-size:16px;font-family: Tahoma, Geneva, sans-serif;color:#2F4F4F;"> Error! Wrong Username or Password. </h1>
				<br><br><a href="index.jsp">Return to Main Page.</a>
			</div>						
			<%}
		}catch(Exception e){
			e.printStackTrace();%>
			<div>
				<h1 style="margin-left:2 em;font-size:16px;font-family: Tahoma, Geneva, sans-serif;color:#2F4F4F;"> Error! Wrong Username or Password. </h1>
				<br><br><a href="index.jsp">Return to Main Page.</a>
			</div>
		<%};
		%>
		
</body>
</html>
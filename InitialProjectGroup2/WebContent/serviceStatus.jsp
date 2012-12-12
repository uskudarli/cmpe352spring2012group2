<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Status of your Services</title>
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
    <br><br><br><br>
		<div class="TableFormat">
			<% Connection con = null;
			String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
			String db = "database2";
			String driver = "com.mysql.jdbc.Driver";
			String userName = "project2";
			String password = "G6v0W7";
			
			Class.forName(driver);
			con = DriverManager.getConnection(url + db, userName, password);
			String userEmail = session.getAttribute("email").toString();
			String serviceTitle = "";
			String serviceDescription = "";
			int serviceId=0;
			String serviceDemanderOrSupplier = "";
			%>
			<table border="1">
				
					<h3>Pending Services</h3>
				
				<tr>
					<td>Service Title</td>
					<td>Service Description</td>
					<td>Service Type</td>
				</tr>
			<% 				
			Statement st = con.createStatement();
			Statement st2 = con.createStatement();
			
			ResultSet rs = st.executeQuery(" SELECT serviceId FROM `Appliers` WHERE email='"+ userEmail +"' ");

			while (rs.next()) {
				serviceId = rs.getInt(1);
				ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
				while(rs2.next()){
					serviceTitle = rs2.getString(2);
					serviceDescription = rs2.getString(3);
					serviceDemanderOrSupplier = rs2.getString(7);
				}
				
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDemanderOrSupplier%></td>
				</tr>
			<%
			}
			%>
			</table><br>
			<table border="1">
				
					<h3>Accepted Services</h3>
				
				<tr>
					<td>Service Title</td>
					<td>Service Description</td>
					<td>Service Type</td>
				</tr>
			<% 							
			rs = st.executeQuery(" SELECT serviceId FROM `AcceptedServices` WHERE email='"+ userEmail +"' ");
			while (rs.next()) {
				serviceId = rs.getInt(1);
				ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
				while(rs2.next()){
					serviceTitle = rs2.getString(2);
					serviceDescription = rs2.getString(3);
					serviceDemanderOrSupplier = rs2.getString(7);
				}
				
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDemanderOrSupplier%></td>
					<td>
						<form action="serviceCompleted.jsp" method="post">
							<input type="hidden" name="serviceId" value=<%=serviceId %>>
							<input type="hidden" name="applierId" value=<%=userEmail %>>	
							<input type ="submit" value="Completed" class="btn btn-primary">
						</form>
					</td>
				</tr>
			<%
			}
			%>
			</table><br>
			<table border="1">
				
					<h3>Rejected Services</h3>
			
				<tr>
					<td>Service Title</td>
					<td>Service Description</td>
					<td>Service Type</td>
				</tr>
			<% 							
			rs = st.executeQuery(" SELECT serviceId FROM `RejectedServices` WHERE email='"+ userEmail +"' ");

			while (rs.next()) {
				serviceId = rs.getInt(1);
				ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
				while(rs2.next()){
					serviceTitle = rs2.getString(2);
					serviceDescription = rs2.getString(3);
					serviceDemanderOrSupplier = rs2.getString(7);
				}
				
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDemanderOrSupplier%></td>
				</tr>
			<%
			}
			%>
			</table><br>
			<table border="1">
				
					<h3>Completed Services</h3>
				
				<tr>
					<td>Service Title</td>
					<td>Service Description</td>
					<td>Service Type</td>
				</tr>
			<% 							
			rs = st.executeQuery(" SELECT serviceId, title, description, demanderOrSupplier FROM `CompletedServices` WHERE email='"+ userEmail +"' ");
			while (rs.next()) {
				serviceId = rs.getInt(1);
				serviceTitle = rs.getString(2);
				serviceDescription = rs.getString(3);
				serviceDemanderOrSupplier = rs.getString(4);				
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDemanderOrSupplier%></td>
					<td>
						<form action="rateService.jsp" method="post">
							<input type="hidden" name="serviceId" value=<%=serviceId %>>
							<input type="hidden" name="applierId" value=<%=userEmail %>>	
							<input type ="submit" value="Rate">
						</form>
					</td>
				</tr>
			<%
			}
			%>
			</table><br><br></div>
		
		<hr><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
	</body>
</html>
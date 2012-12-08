<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Status of your Services</title>
		<link rel="stylesheet" type="text/css" href="./css/MyStyleProfile.css">
	</head>
	<body>
		<form action="searchResult.jsp" method="post"><div class="TableFormat">
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
				<tr>
					<td>Pending Services</td>
				</tr>
				<tr>
					<td><h3>Service Title</h3></td>
					<td><h3>Service Description</h3></td>
					<td><h3>Service Type</h3></td>
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
			</table>
			<table border="1">
				<tr>
					<td>Accepted Services</td>
				</tr>
				<tr>
					<td><h3>Service Title</h3></td>
					<td><h3>Service Description</h3></td>
					<td><h3>Service Type</h3></td>
				</tr>
			<% 							
			rs = st.executeQuery(" SELECT serviceId FROM `AcceptedServices` WHERE email='"+ userEmail +"' ");
			int counter1=0;
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
					<td><div class="button"><input type="submit" name="serviceCompleted<%=counter1%>" value="Completed"></div></td>
				</tr>
			<%
			counter1++;
			}
			%>
			</table>
			<table border="1">
				<tr>
					<td>Rejected Services</td>
				</tr>
				<tr>
					<td><h3>Service Title</h3></td>
					<td><h3>Service Description</h3></td>
					<td><h3>Service Type</h3></td>
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
			</table>
			<table border="1">
				<tr>
					<td>Completed Services</td>
				</tr>
				<tr>
					<td><h3>Service Title</h3></td>
					<td><h3>Service Description</h3></td>
					<td><h3>Service Type</h3></td>
				</tr>
			<% 							
			rs = st.executeQuery(" SELECT serviceId, title, description, demanderOrSupplier FROM `CompletedServices` WHERE email='"+ userEmail +"' ");
			int counter2=0;
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
					<td><div class="button"><input type="submit" name="rateService<%=counter2%>" value="Rate"></div></td>
				</tr>
			<%
			counter2++;
			}
			%>
			</table>
		</form>
		<hr><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
	</body>
</html>
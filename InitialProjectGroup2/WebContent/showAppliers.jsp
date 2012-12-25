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
			int serviceId = Integer.parseInt(request.getParameter("value"));
			String applierName = "";
			String applierSurname = "";
			String applierEmail = "";
			%>
			<table border="1">
				
					<h3>Pending Appliers</h3>
				
				<tr>
					<td>Applier Name</td>
					<td>Applier Surname</td>
					<td>Accept</td>
					<td>Reject</td>
				</tr>
			<% 				
			Statement st = con.createStatement();
			Statement st2 = con.createStatement();
			
			ResultSet rs = st.executeQuery("SELECT User.name, User.surname, User.email FROM User INNER JOIN Appliers ON User.email=Appliers.email WHERE Appliers.serviceId='"+serviceId+"'");

			while (rs.next()) {
				applierName = rs.getString(1);
				applierSurname = rs.getString(2);
				applierEmail = rs.getString(3);			
			%>
				<tr>
					<td><a href="applierProfile.jsp?qid=<%=applierEmail%>"><%=applierName %></a></td>
					<td><%=applierSurname%></td>
					<td>
						<form action="accept.jsp" method="post">
							<input type="hidden" name="applierId" value=<%=applierEmail %>>
							<input type="hidden" name="processId" value=<%=serviceId %>>	
							<input type ="submit" value="Accept" class="btn btn-success">
						</form>
					</td>
					<td>
						<form action="reject.jsp" method="post">
							<input type="hidden" name="applierId" value=<%=applierEmail %>>
							<input type="hidden" name="processId" value=<%=serviceId %>>	
							<input type ="submit" value="Reject" class="btn btn-danger">
						</form>
					</td>
				</tr>
			<%
			}
			%>
			</table><br>
			<table border="1">
				
					<h3>Accepted Appliers</h3>
				
				<tr>
					<td>Applier Name</td>
					<td>Applier Surname</td>
					<td>Complete</td>
				</tr>
			<% 							
			rs = st.executeQuery("SELECT User.name, User.surname, User.email, AcceptedServices.applierApproved, AcceptedServices.serviceProviderApproved FROM User INNER JOIN AcceptedServices ON User.email=AcceptedServices.email WHERE AcceptedServices.serviceId='"+serviceId+"'");
			int applierApproved;
			int serviceProviderApproved;
			String applierApprovedString="";
			while (rs.next()) {
				applierName = rs.getString(1);
				applierSurname = rs.getString(2);
				applierEmail = rs.getString(3);	
				applierApproved = rs.getInt(4);
				serviceProviderApproved = rs.getInt(5);
			%>
				<tr>
					<td><a href="applierProfile.jsp?qid=<%=applierEmail%>"><%=applierName %></a></td>
					<td><%=applierSurname%></td>
					<td><%if(serviceProviderApproved==0){
						applierApprovedString=""+applierApproved;%>
						
						<form action="serviceCompletedP.jsp" method="post">
							<input type="hidden" name="applierId" value=<%=applierEmail %>>
							<input type="hidden" name="serviceId" value=<%=serviceId %>>	
							<input type="hidden" name="applierApproved" value=<%=applierApprovedString %>>
							<input type ="submit" value="Completed" class="btn btn-primary">
						</form>
						<%} 
						else if(applierApproved == 0){
						%>
							Pending approval from Applier
						<%} %>
					</td>
				</tr>
			<%
			}
			%>
			</table><br>
			<table border="1">
				
					<h3>Rejected Appliers</h3>
			
				<tr>
					<td>Applier Name</td>
					<td>Applier Surname</td>
				</tr>
			<% 							
			rs = st.executeQuery("SELECT User.name, User.surname, User.email FROM User INNER JOIN RejectedServices ON User.email=RejectedServices.email WHERE RejectedServices.serviceId='"+serviceId+"'");
			while (rs.next()) {
				applierName = rs.getString(1);
				applierSurname = rs.getString(2);
				applierEmail = rs.getString(3);
				
			%>
				<tr>
					<td><a href="applierProfile.jsp?qid=<%=applierEmail%>"><%=applierName %></a></td>
					<td><%=applierSurname%></td>
				</tr>
			<%
			}
			%>
			</table><br>
			<table border="1">
				
					<h3>Completed Appliers</h3>
				
				<tr>
					<td>Applier Name</td>
					<td>Applier Surname</td>
					<td>Rate</td>
				</tr>
			<% 							
			rs = st.executeQuery("SELECT User.name, User.surname, User.email FROM User INNER JOIN CompletedServices ON User.email=CompletedServices.email WHERE CompletedServices.serviceId='"+serviceId+"'");
			while (rs.next()) {
				applierName = rs.getString(1);
				applierSurname = rs.getString(2);
				applierEmail = rs.getString(3);				
			%>
				<tr>
					<td><a href="applierProfile.jsp?qid=<%=applierEmail%>"><%=applierName %></a></td>
					<td><%=applierSurname%></td>
					<td>
						<form action="rateService.jsp" method="post">
							<input type="hidden" name="applierId" value=<%=applierEmail %>>
							<input type="hidden" name="serviceId" value=<%=serviceId %>>	
							<input type ="submit" value="Rate">
						</form>
					</td>
				</tr>
			<%
			}
			%>
			</table><br><br></div>
			
			<br><a href="OfferedServices.jsp"><strong>&#8249;-- Return to Offered Services</strong></a>
		
		<hr><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
	</body>
</html>
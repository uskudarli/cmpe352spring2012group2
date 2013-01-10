<%@page import="com.mysql.jdbc.ResultSetRow"%>
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
              <li class=""><a href="createService.jsp">Offer a Service</a></li>
              <li class=""><a href="requestService.jsp">Request a Service</a></li>
              <li class=""><a href="searchPage.jsp">Search for a Service</a></li>
            </ul>
            <ul class="nav pull-right">
                  <li><a href="Logout.jsp">Logout</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <br><br><br><br>
    
    <p><b>Below you can see the status of the services that you applied.</b></p>
    
		<div class="TableFormat">
			<% Connection con = null;
			String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
			String db = "database2";
			String driver = "com.mysql.jdbc.Driver";
			String userName = "project2";
			String password = "G6v0W7";
			String serviceOwnerId = "";
			Class.forName(driver);
			con = DriverManager.getConnection(url + db, userName, password);
			String userEmail = session.getAttribute("email").toString();
			String serviceTitle = "";
			String serviceDescription = "";
			int serviceId=0;
			String serviceDemanderOrSupplier = "";
			String ownersEmail = "";
			String ownersPhone = "";
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
			Statement st3 = con.createStatement();
			
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
					<td>Owner's Email</td>
					<td>Owner's Phone</td>
					<td></td>
				</tr>
			<%
			int applierApproved = 0;
			int serviceProviderApproved = 0;
			String serviceProviderApprovedString = "";
			rs = st.executeQuery(" SELECT * FROM `AcceptedServices` WHERE email='"+ userEmail +"' ");
			while (rs.next()) {
				serviceId = rs.getInt(1);
				applierApproved = rs.getInt(3);
				serviceProviderApproved = rs.getInt(4);
				ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
				while(rs2.next()){
					serviceTitle = rs2.getString(2);
					serviceDescription = rs2.getString(3);
					serviceDemanderOrSupplier = rs2.getString(7);
					ownersEmail = rs2.getString(1);
				}
				ResultSet rs3 = st3.executeQuery("SELECT phone FROM `User` WHERE email='" + ownersEmail + "'");
				while(rs3.next()){
					ownersPhone = rs3.getString(1);
				}
				
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDemanderOrSupplier%></td>
					<td><%=ownersEmail%></td>
					<td><%=ownersPhone%></td>
					<td><%if(applierApproved==0){
						serviceProviderApprovedString=""+serviceProviderApproved;%>
						<form action="serviceCompleted.jsp" method="post">
							<input type="hidden" name="serviceId" value=<%=serviceId %>>
							<input type="hidden" name="applierId" value=<%=userEmail %>>	
							<input type="hidden" name="serviceProviderApproved" value=<%=serviceProviderApprovedString %>>	
							<input type ="submit" value="Completed" class="btn btn-primary">
							
						</form>
						<%} 
						else if(serviceProviderApproved == 0){
						%>
							Pending approval from Service Provider
						<%} %>
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
			//rs = null;// st.executeQuery(" SELECT serviceId, title, description, demanderOrSupplier FROM `CompletedServices` WHERE email='"+ userEmail +"' ");
			String myRating;
			rs = st.executeQuery(" SELECT serviceId, partnerRating FROM `CompletedServices` WHERE email='"+ userEmail +"' ");

			while (rs.next()) {
				serviceId = rs.getInt(1);
				myRating = rs.getString(2);
				myRating += " ";
				ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
				while(rs2.next()){
					 serviceOwnerId = rs2.getString(1);
					serviceTitle = rs2.getString(2);
					serviceDescription = rs2.getString(3);
					serviceDemanderOrSupplier = rs2.getString(7);
				}
							%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDemanderOrSupplier%></td>
				<%	if(myRating.equalsIgnoreCase("null ")){ %>
					<td>
						<form action="rateService.jsp" method="post">
							<input type="hidden" name="serviceId" value=<%=serviceId %>>
							<input type="hidden" name="applierId" value=<%=serviceOwnerId %>>
							<input type="hidden" name="pageName" value=<%="serviceStatus" %>>	
							<input type ="submit" value="Rate" class="btn btn-info">
						</form>
					</td>
				<%   } 
					else{%>
					<td>Your rating is: <%=myRating%></td>
			<%		} %>
				</tr>
			<% 
			}
			%>
			</table><br><br></div>
		
		<hr><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
	</body>
</html>

<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>

	



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search Result</title>
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
              <li class="active"><a href="searchPage.jsp">Search For a Service</a></li>
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
			<table border="1">
				
					<h3>Search Results</h3>
				
				<tr>
					<td>Service Title</td>
					<td>Service Description</td>
					<td>Service Start Date</td>
					<td>Service End Date</td>
					<td>Service Tags</td>
					<td>Service Type</td>
					<td>Service Quota</td>
					<td>Service Owner</td>
					<td>Apply for Service</td>
				</tr>
			<%
			
			String tags = request.getParameter("tags");
			String date_start = request.getParameter("date_start");
			String date_end = request.getParameter("date_end");
			String gpsLocation = request.getParameter("gpsLocation");
			
			String[] parsedTags = tags.split(",");
			if(tags.length()!=0){
				for(int i=0; i<parsedTags.length; i++){
					if(i==0)
						tags = "'" + parsedTags[0] + "'";
					else
						tags += "," + "'" + parsedTags[i] + "'";
				}
			}
			
			String[] parsedLocation;
			String latitude="";
			String longtitude="";
			String radius="";
			if(gpsLocation.length() != 0){
				parsedLocation = gpsLocation.split("-");
				latitude = parsedLocation[0];
				longtitude = parsedLocation[1];
				radius = parsedLocation[2];
				radius = radius.substring(0, radius.length()-1);
			}
			
			Connection con = null;
			String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
			String db = "database2";
			String driver = "com.mysql.jdbc.Driver";
			String userName = "project2";
			String password = "G6v0W7";
			
			Class.forName(driver);
			con = DriverManager.getConnection(url + db, userName, password);
			String serviceEmail = "";
			String serviceTitle = "";
			String serviceDescription = "";
			int serviceId=0;
			String serviceTags = "";
			String serviceDateFrom = "";
			String serviceDateTo = "";
			String serviceDemanderOrSupplier = "";
			String serviceApplierQuota = "";
			String serviceLatitude = "";
			String serviceLongitude = "";
			int serviceRadius;
			double[][] distanceArray;
			%>
			<%!
			void insertionSort(double[][] arr, int length) {
			      int i, j;
			      double tmp1, tmp2;
			      for (i = 1; i < length; i++) {
			            j = i;
			            while (j > 0 && arr[j - 1][1] > arr[j][1]) {
			                  tmp1 = arr[j][0];
			                  tmp2 = arr[j][1];
			                  arr[j][0] = arr[j - 1][0];
			                  arr[j][1] = arr[j - 1][1];
			                  arr[j - 1][0] = tmp1;
			                  arr[j - 1][1] = tmp2;
			                  j--;
			            }
			      }
			}
			%>
			<%
			//none of the parameters entered
			if(tags.length() == 0 && date_start.length() == 0 && date_end.length() == 0 && gpsLocation.length() == 0){
			%>
				<p> Enter at least one parameter </p>
			<%	
			}
			//only tags entered
			else if(tags.length() != 0 && date_start.length() == 0 && date_end.length() == 0 && gpsLocation.length() == 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				
				
				tags = tags.replaceAll("','","|");
				tags = tags.replaceAll("'","");
				ResultSet rs = st.executeQuery("SELECT serviceId FROM `Tags` WHERE tag REGEXP '"+tags+"' GROUP BY serviceId ");

				while (rs.next()) {
					serviceId = rs.getInt(1);

					ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
					while(rs2.next()){
						serviceEmail = rs2.getString(1);
						serviceTitle = rs2.getString(2);
						serviceDescription = rs2.getString(3);
						serviceDateFrom = rs2.getString(5);
						serviceDateTo = rs2.getString(6);
						serviceDemanderOrSupplier = rs2.getString(7);
						serviceApplierQuota = rs2.getString(8);	
					}
					
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDateFrom%></td>
					<td><%=serviceDateTo%></td>
					<td><%=serviceTags%></td>
					<td><%=serviceDemanderOrSupplier%></td>
					<td><%=serviceApplierQuota%></td>
					<td>
						<form id="emailSender1" action="applierProfile.jsp" method="post">
							<input type="hidden" name="applierId" value=<%=serviceEmail%>>
						</form>
						<a onclick="document.getElementById('emailSender1').submit()">Owner</a>
					</td>
					<td>
						<form action="ApplyForService.jsp" method="post">
						<input type="submit" value="Apply">
						<input type="hidden" name="processId" value=<%=serviceId %>>	
						</form>
	
					</td>
			</tr>
			<%
				}
				%>
				<tr>
				<td colspan="9">
				 <form action="relatedResults.jsp" method="post" >
					
					<p style="text-align:left;"><b>Would you like to see the related results with the given tag(s)?</b></p>
					<input type="hidden" name="tags" value="<%=tags %>"  maxlength=25 align="right">			
					<input type="submit" method="post" value="Related Results" class="btn btn-primary">
	
				</form>
				</td>
				</tr>
				<% 
			}
			//only date parameters entered
			else if(tags.length() == 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() == 0){
				Statement st = con.createStatement();
				//Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT * FROM `OpenServices` WHERE ( '"+date_start+"' < dateTo AND '"+date_end+"' > dateFrom ) ");

				while (rs.next()) {
					serviceEmail = rs.getString(1);
					serviceId = rs.getInt(4);
					serviceTitle = rs.getString(2);
					serviceDescription = rs.getString(3);
					serviceDateFrom = rs.getString(5);
					serviceDateTo = rs.getString(6);
					serviceDemanderOrSupplier = rs.getString(7);
					serviceApplierQuota = rs.getString(8);	
					
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDateFrom%></td>
					<td><%=serviceDateTo%></td>
					<td><%=serviceTags%></td>
					<td><%=serviceDemanderOrSupplier%></td>
					<td><%=serviceApplierQuota%></td>
					<td>
						<form id="emailSender2" action="applierProfile.jsp" method="post">
							<input type="hidden" name="applierId" value=<%=serviceEmail%>>
						</form>
						<a onclick="document.getElementById('emailSender2').submit()">Owner</a>
					</td>
					<td>
						<form action="ApplyForService.jsp" method="post">
						<input type="submit" value="Apply">
						<input type="hidden" name="processId" value=<%=serviceId %>>	
						</form>
	
					</td>
		</tr>
			<%
				}
			}
			//tags and date parameters entered
			else if(tags.length() != 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() == 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				tags = tags.replaceAll("','","|");
				tags = tags.replaceAll("'","");
				ResultSet rs = st.executeQuery("SELECT serviceId FROM `Tags` WHERE tag REGEXP '"+tags+"' GROUP BY serviceId ");

				while (rs.next()) {
					serviceId = rs.getInt(1);
					boolean flag=false;
					ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE (serviceId='" + serviceId + "' AND '"+date_start+"' < dateTo AND '"+date_end+"' > dateFrom )");
					while(rs2.next()){
						flag=true;
						serviceEmail = rs2.getString(1);
						serviceTitle = rs2.getString(2);
						serviceDescription = rs2.getString(3);
						serviceDateFrom = rs2.getString(5);
						serviceDateTo = rs2.getString(6);
						serviceDemanderOrSupplier = rs2.getString(7);
						serviceApplierQuota = rs2.getString(8);	
					}
					
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
					if(flag){
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDateFrom%></td>
					<td><%=serviceDateTo%></td>
					<td><%=serviceTags%></td>
					<td><%=serviceDemanderOrSupplier%></td>
					<td><%=serviceApplierQuota%></td>
					<td>
						<form id="emailSender3" action="applierProfile.jsp" method="post">
							<input type="hidden" name="applierId" value=<%=serviceEmail%>>
						</form>
						<a onclick="document.getElementById('emailSender3').submit()">Owner</a>
					</td>
					<td>
						<form action="ApplyForService.jsp" method="post">
						<input type="submit" value="Apply">
						<input type="hidden" name="processId" value=<%=serviceId %>>	
						</form>
	
					</td>
					
				</tr>
			<%
					}
				}
				%>
				<tr>
				<td colspan="9">
				 <form action="relatedResults.jsp" method="post" >
					
					<p style="text-align:left;"><b>Would you like to see the related results with the given tag(s)?</b></p>
					<input type="hidden" name="tags" value="<%=tags %>"  maxlength=25 align="right">			
					<input type="submit" method="post" value="Related Results" class="btn btn-primary">
	
				</form>
				</td>
				</tr>
				<% 
			}
			//only location parameter is entered
			else if(tags.length() == 0 && date_start.length() == 0 && date_end.length() == 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT * FROM `Place` ");
				
				String printedServiceIds = "";
				String currentServiceId = "";
				rs.last();
				distanceArray = new double[rs.getRow()][2];
				rs.beforeFirst();
				int i=0;
				while (rs.next()) {
					double R = 6371; // km
					double lat1 = Double.parseDouble(rs.getString(2));
					double lon1 = Double.parseDouble(rs.getString(3));
					double lat2 = Double.parseDouble(latitude);
					double lon2 = Double.parseDouble(longtitude);
					
					double dLat = (lat2-lat1)*Math.PI/180;
					double dLon = (lon2-lon1)*Math.PI/180;
					lat1 = lat1*Math.PI/180;
					lat2 = lat2*Math.PI/180;

					double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
					        Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
					double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
					double distance = R * c;
					
					
					currentServiceId = "'" + Integer.toString(rs.getInt(1)) + "'";
					
					if(distance < rs.getInt(4)+Integer.parseInt(radius) && !printedServiceIds.contains(currentServiceId)){
						printedServiceIds += "'" + currentServiceId + "'";
						serviceId = rs.getInt(1);
						distanceArray[i][0]=serviceId;
						distanceArray[i][1]=distance;
						i++;
					}
				}
				insertionSort(distanceArray, i);
				for(int j=0; j<i; j++){
					serviceId = (int)distanceArray[j][0];
					ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
					while(rs2.next()){
						serviceEmail = rs2.getString(1);
						serviceTitle = rs2.getString(2);
						serviceDescription = rs2.getString(3);
						serviceDateFrom = rs2.getString(5);
						serviceDateTo = rs2.getString(6);
						serviceDemanderOrSupplier = rs2.getString(7);
						serviceApplierQuota = rs2.getString(8);	
					}
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
			%>
					<tr>
						<td><%=serviceTitle%></td>
						<td><%=serviceDescription%></td>
						<td><%=serviceDateFrom%></td>
						<td><%=serviceDateTo%></td>
						<td><%=serviceTags%></td>
						<td><%=serviceDemanderOrSupplier%></td>
						<td><%=serviceApplierQuota%></td>
						<td>
							<form id="emailSender4" action="applierProfile.jsp" method="post">
								<input type="hidden" name="applierId" value=<%=serviceEmail%>>
							</form>
							<a onclick="document.getElementById('emailSender4').submit()">Owner</a>
						</td>
						<td>
							<form action="ApplyForService.jsp" method="post">
							<input type="submit" value="Apply">
							<input type="hidden" name="processId" value=<%=serviceId %>>	
							</form>

						</td>

					</tr>
			<%
				}
			}
			//tags and location parameters entered
			else if(tags.length() != 0 && date_start.length() == 0 && date_end.length() == 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				Statement st4 = con.createStatement();
				tags = tags.replaceAll("','","|");
				tags = tags.replaceAll("'","");
				ResultSet rs = st.executeQuery("SELECT serviceId FROM `Tags` WHERE tag REGEXP '"+tags+"' GROUP BY serviceId ");
				rs.last();
				distanceArray = new double[rs.getRow()][2];
				rs.beforeFirst();
				int i=0;
				while (rs.next()) {
					serviceId = rs.getInt(1);
					ResultSet rs2 = st2.executeQuery("SELECT * FROM `Place` WHERE (serviceId='" + serviceId + "')");
					while(rs2.next()){
						double R = 6371; // km
						double lat1 = Double.parseDouble(rs2.getString(2));
						double lon1 = Double.parseDouble(rs2.getString(3));
						double lat2 = Double.parseDouble(latitude);
						double lon2 = Double.parseDouble(longtitude);
						
						double dLat = (lat2-lat1)*Math.PI/180;
						double dLon = (lon2-lon1)*Math.PI/180;
						lat1 = lat1*Math.PI/180;
						lat2 = lat2*Math.PI/180;
	
						double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
						        Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
						double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
						double distance = R * c;
						
						if(distance < rs2.getInt(4)+Integer.parseInt(radius)){
							serviceId = rs.getInt(1);
							distanceArray[i][0]=serviceId;
							distanceArray[i][1]=distance;
							i++;
							break;
						}
					}
				}
				insertionSort(distanceArray,i);
				for(int j=0; j<i; j++){
					serviceId = (int)distanceArray[j][0];
					ResultSet rs4 = st4.executeQuery("Select * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
					while(rs4.next()){
						serviceEmail = rs4.getString(1);
						serviceTitle = rs4.getString(2);
						serviceDescription = rs4.getString(3);
						serviceDateFrom = rs4.getString(5);
						serviceDateTo = rs4.getString(6);
						serviceDemanderOrSupplier = rs4.getString(7);
						serviceApplierQuota = rs4.getString(8);
					}
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
					%>
					<tr>
						<td><%=serviceTitle%></td>
						<td><%=serviceDescription%></td>
						<td><%=serviceDateFrom%></td>
						<td><%=serviceDateTo%></td>
						<td><%=serviceTags%></td>
						<td><%=serviceDemanderOrSupplier%></td>
						<td><%=serviceApplierQuota%></td>
						<td>
							<form id="emailSender5" action="applierProfile.jsp" method="post">
								<input type="hidden" name="applierId" value=<%=serviceEmail%>>
							</form>
							<a onclick="document.getElementById('emailSender5').submit()">Owner</a>
						</td>
						<td>
							<form action="ApplyForService.jsp" method="post">
							<input type="submit" value="Apply">
							<input type="hidden" name="processId" value=<%=serviceId %>>	
							</form>
		
						</td>

					</tr>
				<%
				}
				%>
				<tr>
				<td colspan="9">
				 <form action="relatedResults.jsp" method="post" >
					
					<p style="text-align:left;"><b>Would you like to see the related results with the given tag(s)?</b></p>
					<input type="hidden" name="tags" value="<%=tags %>"  maxlength=25 align="right">			
					<input type="submit" method="post" value="Related Results" class="btn btn-primary">
	
				</form>
				</td>
				</tr>
				<% 
			}
			//date and location parameters entered
			else if(tags.length() == 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				Statement st4 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT * FROM `OpenServices` WHERE ( '"+date_start+"' < dateTo AND '"+date_end+"' > dateFrom ) ");
				rs.last();
				distanceArray = new double[rs.getRow()][2];
				rs.beforeFirst();
				int i=0;
				while (rs.next()) {
					serviceId = rs.getInt(4);
					ResultSet rs2 = st2.executeQuery("SELECT * FROM `Place` WHERE (serviceId='" + serviceId + "')");
					while(rs2.next()){
						double R = 6371; // km
						double lat1 = Double.parseDouble(rs2.getString(2));
						double lon1 = Double.parseDouble(rs2.getString(3));
						double lat2 = Double.parseDouble(latitude);
						double lon2 = Double.parseDouble(longtitude);
						
						double dLat = (lat2-lat1)*Math.PI/180;
						double dLon = (lon2-lon1)*Math.PI/180;
						lat1 = lat1*Math.PI/180;
						lat2 = lat2*Math.PI/180;
	
						double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
						        Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
						double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
						double distance = R * c;
						
						if(distance < rs2.getInt(4)+Integer.parseInt(radius)){
							serviceId = rs.getInt(4);
							distanceArray[i][0]=serviceId;
							distanceArray[i][1]=distance;
							i++;
							break;
						}
					}
				}
				insertionSort(distanceArray,i);
				for(int j=0; j<i; j++){
					serviceId = (int)distanceArray[j][0];
					ResultSet rs4 = st4.executeQuery("Select * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
					while(rs4.next()){
						serviceEmail = rs4.getString(1);
						serviceTitle = rs4.getString(2);
						serviceDescription = rs4.getString(3);
						serviceDateFrom = rs4.getString(5);
						serviceDateTo = rs4.getString(6);
						serviceDemanderOrSupplier = rs4.getString(7);
						serviceApplierQuota = rs4.getString(8);
					}
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
					%>
					<tr>
						<td><%=serviceTitle%></td>
						<td><%=serviceDescription%></td>
						<td><%=serviceDateFrom%></td>
						<td><%=serviceDateTo%></td>
						<td><%=serviceTags%></td>
						<td><%=serviceDemanderOrSupplier%></td>
						<td><%=serviceApplierQuota%></td>
						<td>
							<form id="emailSender6" action="applierProfile.jsp" method="post">
								<input type="hidden" name="applierId" value=<%=serviceEmail%>>
							</form>
							<a onclick="document.getElementById('emailSender6').submit()">Owner</a>
						</td>
						<td>
							<form action="ApplyForService.jsp" method="post">
							<input type="submit" value="Apply">
							<input type="hidden" name="processId" value=<%=serviceId %>>	
							</form>
		
						</td>

					</tr>
				<%
				}
			}
			//tags, date and location parameters entered
			else if(tags.length() != 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				Statement st4 = con.createStatement();
				tags = tags.replaceAll("','","|");
				tags = tags.replaceAll("'","");
				ResultSet rs = st.executeQuery("SELECT Tags.serviceId FROM `Tags`,`OpenServices` WHERE (Tags.serviceId = OpenServices.serviceId AND Tags.tag REGEXP '" +tags+"' AND '"+date_start+"' < OpenServices.dateTo AND '"+date_end+"' > OpenServices.dateFrom) GROUP BY serviceId ");
				rs.last();
				distanceArray = new double[rs.getRow()][2];
				rs.beforeFirst();
				int i=0;
				while (rs.next()) {
					serviceId = rs.getInt(1);
					boolean flag=false;
					ResultSet rs2 = st2.executeQuery("SELECT * FROM `Place` WHERE (serviceId='" + serviceId + "')");
					while(rs2.next()){
						double R = 6371; // km
						double lat1 = Double.parseDouble(rs2.getString(2));
						double lon1 = Double.parseDouble(rs2.getString(3));
						double lat2 = Double.parseDouble(latitude);
						double lon2 = Double.parseDouble(longtitude);
						
						double dLat = (lat2-lat1)*Math.PI/180;
						double dLon = (lon2-lon1)*Math.PI/180;
						lat1 = lat1*Math.PI/180;
						lat2 = lat2*Math.PI/180;
	
						double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
						        Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
						double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
						double distance = R * c;
						
						if(distance < rs2.getInt(4)+Integer.parseInt(radius)){
							serviceId = rs.getInt(1);
							distanceArray[i][0]=serviceId;
							distanceArray[i][1]=distance;
							i++;
							break;
						}
					}
				}
				insertionSort(distanceArray,i);
				for(int j=0; j<i; j++){
					serviceId = (int)distanceArray[j][0];
					ResultSet rs4 = st4.executeQuery("Select * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
					while(rs4.next()){
						serviceEmail = rs4.getString(1);
						serviceTitle = rs4.getString(2);
						serviceDescription = rs4.getString(3);
						serviceDateFrom = rs4.getString(5);
						serviceDateTo = rs4.getString(6);
						serviceDemanderOrSupplier = rs4.getString(7);
						serviceApplierQuota = rs4.getString(8);
					}
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
					%>
					<tr>
						<td><%=serviceTitle%></td>
						<td><%=serviceDescription%></td>
						<td><%=serviceDateFrom%></td>
						<td><%=serviceDateTo%></td>
						<td><%=serviceTags%></td>
						<td><%=serviceDemanderOrSupplier%></td>
						<td><%=serviceApplierQuota%></td>
						<td>
							<form id="emailSender7" action="applierProfile.jsp" method="post">
								<input type="hidden" name="applierId" value=<%=serviceEmail%>>
							</form>
							<a onclick="document.getElementById('emailSender7').submit()">Owner</a>
						</td>
						<td>
							<form action="ApplyForService.jsp" method="post">
							<input type="submit" value="Apply">
							<input type="hidden" name="processId" value=<%=serviceId %>>	
							</form>
		
						</td>

					</tr>
				<%
				}
				%>
				<tr>
				<td colspan="9">
				 <form action="relatedResults.jsp" method="post" >
					
					<p style="text-align:left;"><b>Would you like to see the related results with the given tag(s)?</b></p>
					<input type="hidden" name="tags" value="<%=tags %>"  maxlength=25 align="right">			
					<input type="submit" method="post" value="Related Results" class="btn btn-primary">
	
				</form>
				</td>
				</tr>
				<% 
			}
			else{
			%>
				<p> Enter correct parameter </p>
			<%
			}
			%>
			</table>
		
		<hr><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
	</body>
</html>
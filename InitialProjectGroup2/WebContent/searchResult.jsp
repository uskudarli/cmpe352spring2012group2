<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Search Result</title>
	</head>

	<body>
		<form>
			<table border="1">
				<tr>
					<td>Search Results</td>
				</tr>
				<tr>
					<td>Service Title</td>
					<td>Service Description</td>
					<td>Service Start Date</td>
					<td>Service End Date</td>
					<td>Service Tags</td>
					<td>Service Type</td>
					<td>Service Quota</td>
					<td>Service Owner</td>
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
				
				ResultSet rs = st.executeQuery("SELECT serviceId FROM `Tags` WHERE tag IN("+tags+") GROUP BY serviceId ");

				while (rs.next()) {
					serviceId = rs.getInt(1);

					ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
					while(rs2.next()){
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
					<td><a href="showOwner.jsp?value=<%=serviceId%>">Owner</a></td>
				</tr>
			<%
				}
			}
			//only date parameters entered
			else if(tags.length() == 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() == 0){
				Statement st = con.createStatement();
				//Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT * FROM `OpenServices` WHERE ( '"+date_start+"' < dateTo AND '"+date_end+"' > dateFrom ) ");

				while (rs.next()) {
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
					<td><a href="showOwner.jsp?value=<%=serviceId%>">Owner</a></td>
				</tr>
			<%
				}
			}
			//tags and date parameters entered
			else if(tags.length() != 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() == 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT serviceId FROM `Tags` WHERE tag IN("+tags+") GROUP BY serviceId ");

				while (rs.next()) {
					serviceId = rs.getInt(1);
					boolean flag=false;
					ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE (serviceId='" + serviceId + "' AND '"+date_start+"' < dateTo AND '"+date_end+"' > dateFrom )");
					while(rs2.next()){
						flag=true;
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
					<td><a href="showOwner.jsp?value=<%=serviceId%>">Owner</a></td>
				</tr>
			<%
					}
				}
			}
			//only location parameter is entered
			else if(tags.length() == 0 && date_start.length() == 0 && date_end.length() == 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT * FROM `Place` ");
				
				String printedServiceIds = "";
				String currentServiceId = "";
				
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
						ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
						while(rs2.next()){
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
							<td><a href="showOwner.jsp?value=<%=serviceId%>">Owner</a></td>
						</tr>
				<%
					}

				}
			}
			//tags and location parameters entered
			else if(tags.length() != 0 && date_start.length() == 0 && date_end.length() == 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				Statement st4 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT serviceId FROM `Tags` WHERE tag IN("+tags+") GROUP BY serviceId ");

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
							ResultSet rs4 = st4.executeQuery("Select * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
							while(rs4.next()){
								serviceTitle = rs4.getString(2);
								serviceDescription = rs4.getString(3);
								serviceDateFrom = rs4.getString(5);
								serviceDateTo = rs4.getString(6);
								serviceDemanderOrSupplier = rs4.getString(7);
								serviceApplierQuota = rs4.getString(8);
							}
							flag = true;
							break;
						}
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
					<td><a href="showOwner.jsp?value=<%=serviceId%>">Owner</a></td>
				</tr>
			<%
					}
				}
			}
			//date and location parameters entered
			else if(tags.length() == 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT * FROM `OpenServices` WHERE ( '"+date_start+"' < dateTo AND '"+date_end+"' > dateFrom ) ");

				while (rs.next()) {
					serviceId = rs.getInt(4);
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
							serviceTitle = rs.getString(2);
							serviceDescription = rs.getString(3);
							serviceDateFrom = rs.getString(5);
							serviceDateTo = rs.getString(6);
							serviceDemanderOrSupplier = rs.getString(7);
							serviceApplierQuota = rs.getString(8);
							flag = true;
							break;
						}
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
					<td><a href="showOwner.jsp?value=<%=serviceId%>">Owner</a></td>
				</tr>
			<%
					}
				}
			}
			//tags, date and location parameters entered
			else if(tags.length() != 0 && date_start.length() != 0 && date_end.length() != 0 && gpsLocation.length() != 0){
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				Statement st4 = con.createStatement();
				
				ResultSet rs = st.executeQuery("SELECT Tags.serviceId FROM `Tags`,`OpenServices` WHERE (Tags.tag IN("+tags+") AND '"+date_start+"' < OpenServices.dateTo AND '"+date_end+"' > OpenServices.dateFrom) GROUP BY serviceId ");

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
							ResultSet rs4 = st4.executeQuery("Select * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
							while(rs4.next()){
								serviceTitle = rs4.getString(2);
								serviceDescription = rs4.getString(3);
								serviceDateFrom = rs4.getString(5);
								serviceDateTo = rs4.getString(6);
								serviceDemanderOrSupplier = rs4.getString(7);
								serviceApplierQuota = rs4.getString(8);
							}
							flag = true;
							break;
						}
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
					<td><a href="showOwner.jsp?value=<%=serviceId%>">Owner</a></td>
				</tr>
			<%
					}
				}
			}
			else{
			%>
				<p> Enter correct parameter </p>
			<%
			}
			%>
			</table>
		</form>
	</body>
</html>
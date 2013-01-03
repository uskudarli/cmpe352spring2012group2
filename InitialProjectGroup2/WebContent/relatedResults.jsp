<%@page import="com.sun.xml.internal.fastinfoset.util.StringArray"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
<%@ page import="net.jeremybrooks.knicker.AccountApi" %>	
<%@ page import="net.jeremybrooks.knicker.WordApi" %>	
<%@ page import="net.jeremybrooks.knicker.dto.Related" %>	
<%@ page import="net.jeremybrooks.knicker.dto.TokenStatus;" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Related Results</title>
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
				
					<h3>Related Results</h3>
				
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
			System.setProperty("WORDNIK_API_KEY", "32deba78c0b807c64100704664b0d7ce54e542653ebe5a017");
			TokenStatus status = AccountApi.apiTokenStatus();
			if (status.isValid()) {
			    System.out.println("API key is valid.");
			} else {
			    System.out.println("API key is invalid!");
			    System.exit(1);
			}
			String tags = request.getParameter("tags");
			String date_start = request.getParameter("date_start");
			String date_end = request.getParameter("date_end");
			String gpsLocation = request.getParameter("gpsLocation");
			
			
			
			String[] parsedTags = tags.split("[|]");
			
			
			
			
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
			int flag;
			String myEmail = session.getAttribute("email").toString();
			//none of the parameters entered
			
				Statement st = con.createStatement();
				Statement st2 = con.createStatement();
				Statement st3 = con.createStatement();
				for(String tag : parsedTags){
				List<Related> def = WordApi.related(tag);
				for (Related d : def) {
				    List<String> wordList = d.getWords();
				    for(String word : wordList){
				    	if(word.split(" ").length==1)
				    	tags+="|'"+word;
				    }
				}
				}
				/*test purpose*/
				//System.out.println(tags);
				
				
				tags = tags.replaceAll("'","");
				/*test purpose*/
				System.out.println(tags);
				
				
				ResultSet rs = st.executeQuery("SELECT serviceId FROM `Tags` WHERE tag REGEXP '"+tags+"' GROUP BY serviceId ");

				while (rs.next()) {
					serviceId = rs.getInt(1);
					flag=1;

					ResultSet rs2 = st2.executeQuery("SELECT * FROM `OpenServices` WHERE serviceId='" + serviceId + "'");
					while(rs2.next()){
						serviceEmail = rs2.getString(1);
						serviceTitle = rs2.getString(2);
						serviceDescription = rs2.getString(3);
						serviceDateFrom = rs2.getString(5);
						serviceDateTo = rs2.getString(6);
						serviceDemanderOrSupplier = rs2.getString(7);
						serviceApplierQuota = rs2.getString(8);
						if(Integer.parseInt(serviceApplierQuota)<1 || serviceEmail.equals(myEmail))
							flag=0;
					}
					
					ResultSet rs3 = st3.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='" + serviceId + "'");
					serviceTags="";
					while (rs3.next()) {
						serviceTags += rs3.getString(1)+ ",";
					}
					serviceTags = serviceTags.substring(0,serviceTags.length()-1);
					if(flag==1){
			%>
				<tr>
					<td><%=serviceTitle%></td>
					<td><%=serviceDescription%></td>
					<td><%=serviceDateFrom%></td>
					<td><%=serviceDateTo%></td>
					<td><%=serviceTags%></td>
					<td><%=serviceDemanderOrSupplier%></td>
					<td><%=serviceApplierQuota%></td>
					<td><a href="applierProfile.jsp?qid=<%=serviceEmail%>">Owner</a></td>
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
			</table>
		
		<hr><br><br><hr><div id="footer"><p>Copyright © Boun Cmpe451 - Group 2</p></div>
	</body>
</html>
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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/MyStyleProfile.css">
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li class=""><a href="profile.jsp">Home</a></li>
						<li class=""><a href="profile.jsp">Profile</a></li>
						<li class=""><a href="searchPage.jsp">Search For a
								Service</a></li>
					</ul>
					<ul class="nav pull-right">
						<li><a href="Logout.jsp">Logout</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<%!
	        String decryptString(String str){
	        	StringBuffer sb = new StringBuffer (str);
			      int lenStr = str.length();
			      // For each character in our string, encrypt it...
			      for ( int i = 0; i < lenStr; i++ ){
			         sb.setCharAt(i, (char)(str.charAt(i) +23)); 
			      }
			      return sb.toString();
	   		}
	%>
	<%
		String username = "";
		username = (String)(request.getParameter("qid"));
		username = decryptString(username);

		try {
			DBConnection db = new DBConnection();
			ResultSet rs = db
					.executeQuery("Select * from User where email='"
							+ username + "'");
			if (rs.next()) {

				String mail = rs.getString(1);
				//String pass=rs.getString(2);
				String name = rs.getString(3);
				String surname = rs.getString(4);
				String credit = rs.getString(5);
				String rating = rs.getString(6);
				String phone = rs.getString(7);
				String about = rs.getString(8);
				String ratingCount = rs.getString(9);
				about = URLDecoder.decode(about, "UTF-8");
				/*session.setAttribute( "email", mail );
				session.setAttribute( "password", pass );
				session.setAttribute( "name", name );
				session.setAttribute( "surname", surname );
				session.setAttribute( "credit", credit );
				session.setAttribute( "rating", rating );
				session.setAttribute( "phone", phone );
				session.setAttribute( "about", about );
				 */
				if (name.equals("NULL"))
					request.getRequestDispatcher("completeRegistration.jsp")
							.forward(request, response);
				 
				 
				 DBConnection db2 = new DBConnection();
				 ResultSet rs2 = db2.executeQuery("select comment from CompletedServices where email = '"+username+"'");
				 DBConnection db3 = new DBConnection();
				 ResultSet rs3 = db3.executeQuery("select CompletedServices.partnerComment from CompletedServices where CompletedServices.serviceId IN (select OpenServices.serviceId from OpenServices where OpenServices.email = '"+username+"')");
				 DBConnection db4 = new DBConnection();
				 ResultSet rs4 = db4.executeQuery("select * from OpenServices where email = '"+username+"'");
	%>

	<div id="wrapper">
	<div id="content2">
	<h1><%=name + " " + surname%></h1>

		<!--  <p style="font-size:24px;"><b><%=name + " " + surname%></b></p> -->
		<ul>
			<!-- <li> <b><%=name + " " + surname%></b> -->
			<!--  <li> <b>Social Credit: </b><%=credit%> -->
			<!-- <li> <b>Rating: </b><%=rating%> -->
			<!-- <li> <b>Mobile Phone:</b><%=phone%> -->
			
			<li><b>  Personal Information:  </b><%=about%> 
			<li><b><a id="displayText" href="javascript:toggle();">Show Comments</a></b>
			<script language="javascript">
				function toggle() {
					var ele = document.getElementById("toggleText");
					var text = document.getElementById("displayText");
					if (ele.style.display == "block") {
						ele.style.display = "none";
						text.innerHTML = "Show Comments";
					} else {
						ele.style.display = "block";
						text.innerHTML = "Hide Comments";
					}
				}
			</script>
			 
				<div id="toggleText" style="display: none" class="table table-hover">
				<table>
					<%
					out.println("<tr><td><b>Comments From Appliers</b></td></tr>");
					while(rs3.next()){
						if(rs3.getString(1)!=null)
						out.println("<tr><td>"+rs3.getString(1)+"</td></tr>");
					}
					out.println("</table>");
					%><br><%
					out.println("<table>");
					out.println("<tr><td><b>Comments From Service Owners<b></td></tr>");
					while(rs2.next()){
						if(rs2.getString(1)!=null)
						out.println("<tr><td>"+rs2.getString(1)+"</td></tr>");
					}
					%>
					</table>
					
				</div>
			<li><b><a id="displayText2" href="javascript:toggle2();">Show Services Offered & Requested</a></b>
			<script language="javascript">
				function toggle2() {
					var ele2 = document.getElementById("toggleText2");
					var text2 = document.getElementById("displayText2");
					if (ele2.style.display == "block") {
						ele2.style.display = "none";
						text2.innerHTML = "Show Services Offered & Requested";
					} else {
						ele2.style.display = "block";
						text2.innerHTML = "Hide Services Offered & Requested";
					}
				}
			</script>
			 
				<div id="toggleText2" style="display: none" class="table table-bordered">
				<table>
				<thead>
				<tr>
					<th>Service Title</th>
					<th>Service Description</th>
					<th>Service Start Date</th>
					<th>Service End Date</th>
					<th>Service Type</th>
					<th>Service Quota</th>
					<th>Apply for Service</th>
				</tr>
				</thead>
				<%
				while(rs4.next()){
						out.println("<tr><td>"+rs4.getString(2)+"</td>");
						out.println("<td>"+rs4.getString(3)+"</td>");
						out.println("<td>"+rs4.getString(5)+"</td>");
						out.println("<td>"+rs4.getString(6)+"</td>");
						out.println("<td>"+rs4.getString(7)+"</td>");
						out.println("<td>"+rs4.getString(8)+"</td>");
						%>
						<td>
						<form action="ApplyForService.jsp" method="post">
						<input type="submit" value="Apply" class="btn btn-primary">
						<input type="hidden" name="processId" value=<%=rs4.getString(4) %>>	
						</form>
	
					</td>
					</tr>
					<% 
					}
				%>
				</table>
					
				</div>
		</ul>

	</div>
	</div>

	<br><br><br>

	<div id="extra">
		<p style="font-size: 21px;">
			<b>Social Credit: <i><%=credit%></i><br>Rating: <i><%=rating%></i></b> (<%=ratingCount%> times rated)
		</p>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<hr>
	<div id="footer">
		<p>Copyright © Boun Cmpe451 - Group 2</p>
	</div>


	<%
		} else
				out.print("Error! Wrong Username or Password ");

		} catch (Exception e) {
			e.printStackTrace();
			out.print("Error! Wrong Username or Password ");
		}
		;
	%>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Requested Services</title>

<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="./css/MyStyleProfile.css">
</head>
<!-- <div id="footer_top"><p></p></div><hr>  -->

<script type="text/javascript">
	function show(index) {
		if (document.getElementById("content" + index).style.display == "block") {
			document.getElementById("content" + index).style.display = "none";
		} else {
			document.getElementById("content" + index).style.display = "block";
		}
	}
</script>
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
<h1>Requested Services</h1><hr>
	<form action="requestedServices.jsp" method="post"><div class="TableFormat">

			<%
				String email = session.getAttribute("email").toString();
				Connection con = null;
				String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
				String db = "database2";
				String driver = "com.mysql.jdbc.Driver";
				String userName = "project2";
				String password = "G6v0W7";

				try {
					Class.forName(driver);
					con = DriverManager.getConnection(url + db, userName, password);
					String title = "";
					String description = "";
					int serviceId;
					String dateFrom = "";
					String dateTo = "";
					String latitude = "";
					String longitude = "";
					int radius = 0;
					
					int i = 0;

					try {
						Statement st = con.createStatement();
						Statement st2 = con.createStatement();
						Statement st3 = con.createStatement();

						ResultSet rs = st
								.executeQuery("SELECT * FROM `OpenServices` WHERE (email='"
										+ email + "' and demanderOrSupplier='demander')  ");

						boolean IsRowExist=rs.next();
						
						if(IsRowExist){%>
							<table border="3">
							<tr>
							<td>Service Title</td>
							<td>Service Description</td>
							<td>Service Start Date</td>
							<td>Service End Date</td>
							<td>Service Tags</td>
							</tr><% }
						else{ %>
							<p>You don't have any requested services yet.</p>
						<% }
						while (IsRowExist) {
							title = rs.getString(2);
							description = rs.getString(3);
							serviceId = rs.getInt(4);
							dateFrom = rs.getString(5);
							dateTo = rs.getString(6);

							ResultSet rs2 = st3
									.executeQuery("SELECT tag FROM `Tags` WHERE serviceId='"
											+ serviceId + "'");
							String tag = "";
							while (rs2.next()) {
								tag += rs2.getString(1)+ " ";
							}
							tag=tag.substring(0,tag.length()-1);
			%>
			

			<tr>
				<td><%=title%></td>
				<td><%=description%></td>
				<td><%=dateFrom%></td>
				<td><%=dateTo%></td>
				<td><%=tag%></td>
				<td><div><input type="submit" name="deleteTitle<%=i%>"
					value="Delete" class="btn btn-inverse"></div>
				</td>
			</tr>
					

		<%
				i++;
				IsRowExist=rs.next();
					}
					st.close();
				} catch (Exception e1) {
				}
				int k1 = 0;
				while (request.getParameter("deleteTitle" + k1) == null) {
					k1++;
					if (k1 > i)
						break;
				}
				if (request.getParameter("deleteTitle" + k1) != null) {
					try {
						String nameOfButton = request
								.getParameter("deleteTitle" + k1);
						Statement st1 = con.createStatement();
						String serviceNumber = String.valueOf(k1);

						ResultSet rs2 = st1
								.executeQuery("SELECT * FROM `OpenServices` WHERE email='"
										+ email + "'");

						int k = 0;
						String serviceId2 = "";
						while (rs2.next()) {

							if (k == Integer.parseInt(serviceNumber)) {
								serviceId = rs2.getInt(4);
								serviceId2 = Integer.toString(serviceId);
								System.out.println("service ID2 : "
										+ serviceId2);
							}
							k++;
						}
						st1.executeUpdate("DELETE FROM `database2`.`OpenServices` WHERE `OpenServices`.`serviceId` = '"
								+ serviceId2 + "'");
						st1.executeUpdate("DELETE FROM `database2`.`Tags` WHERE `Tags`.`serviceId` = '"
								+ serviceId2 + "'");
						st1.executeUpdate("DELETE FROM `database2`.`Place` WHERE `Place`.`serviceId` = '"
								+ serviceId2 + "'");
		%>
		<script type="text/javascript">
			location.reload(true);
		</script>
		<%
			st1.close();
					} catch (Exception e2) {
						e2.printStackTrace();
						System.out.println("hata");
					}
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
</table></div>
	</form>
	<hr><!--  <div id="footer_top"><p></p></div> -->
	
	<br><br><hr><div id="footer"><p>Copyright � Boun Cmpe451 - Group 2</p></div>
</body>
</html>
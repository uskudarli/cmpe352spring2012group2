<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Offered Services</title>
</head>
	
		<script type="text/javascript">
		function show(index) {
			if (document.getElementById("content"+index).style.display=="block") {
				document.getElementById("content"+index).style.display="none";	
			} else {
			document.getElementById("content"+index).style.display="block";
			}
		}
		</script>
<body>



<%
		String email = session.getAttribute( "email" ).toString();
		Connection con = null;
		String url = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
		String db = "database2";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "project2";
		String password = "G6v0W7";

		try {
		Class.forName(driver);
		con = DriverManager.getConnection(url + db, userName, password);
		String title="";
		String description="";
		int serviceId;
		String dateFrom="";
		String dateTo="";
		String latitude="";
		String longitude="";
		int radius;
		String tag="";
		int i = 0;
		int j = 0;
		
		try {
			Statement st = con.createStatement();
			Statement st2 = con.createStatement();
			Statement st3 = con.createStatement();
			
			ResultSet rs = st
			.executeQuery("SELECT * FROM `OpenServices` WHERE email='"
			+ email + "'");
			
			
			
			while (rs.next()) {
					title = rs.getString(2);
					description = rs.getString(3);
					serviceId = rs.getInt(4);
					dateFrom = rs.getString(5);
					dateTo = rs.getString(6);
					
					ResultSet rs1 = st2
							.executeQuery("SELECT * FROM `Place` WHERE serviceId='"
							+ serviceId + "'");
					ResultSet rs2 = st3
							.executeQuery("SELECT * FROM `Tags` WHERE serviceId='"
							+ serviceId + "'");
					
					
					
%>


<br />
<form action="OfferedServices.jsp" method="post">

<input type="button"onclick="show(<%=i%>)"  value="<%=title%>">
        <div id="content<%=i%>" style="display:none" >
<table>

		<tr>
			<a href="showAppliers.jsp?value=<%=serviceId%>"><%=title %>
			</a>
		</tr>
		
		<tr>
		<td>Title:</td>
		<td><input id="title<%=i%>" type="text" name="titlebox<%=i%>"
		value="<%=title%>"></td>
		</tr>
		
		
		<tr>
		
		<td>Description:</td>
		<td><textarea rows="5" cols="30" name="description<%=i%>"><%=description%>
		<%
		System.out.println(description);
		%>
		</textarea></td>
		
		</tr>
		
		<tr>
		
		<td><input type="hidden" name="serviceIdBox<%=i%>"
		value="<%=serviceId%>"></td>
		
		</tr>
		
		<tr>
		<td>Date From:</td>
		<td><input class="hasDatepicker" type="text" id="dateFromBox" name="dateFromBox<%=i%>"
		value="<%=dateFrom%>"></td>
		
		</tr>
		
		<tr>
		<td>Date To:</td>
		<td><input class="hasDatepicker"  type="text" id="dateToBox" name="dateToBox<%=i%>" value="<%=dateTo%>"></td>
		
		</tr>
		
		
		<!-- 	
		<tr>
		<td>Tags:</td>
		<td>
		<%-- <textarea rows="5" cols="30" id="tags" name="tags<%=i%>"><%=tag%>
		
		</textarea> --%>
		<input id="tags" name="tags<%=i%>"/><br>  
		
		
		
		</td>
		
		</tr>  -->
		
		

		
		<!-- 
		<%
			j=0;
		    while(rs1.next()){
				latitude=rs1.getString(2);
				longitude=rs1.getString(3);
				radius=rs1.getInt(4);%>
		<tr>
		<td>Latitude:</td>
		<td><input type="text" id="latitudeBox" name="latitudeBox<%=i%>_<%=j%>_0" value="<%=latitude%>"></td>
		<td>Longitude:</td>
		<td><input type="text" id="longitudeBox" name="longitudeBox<%=i%>_<%=j%>_1" value="<%=longitude%>"></td>
		<td>Radius:</td>
		<td><input type="text" id="radiusBox" name="radiusBox<%=i%>_<%=j%>_2" value="<%=radius%>"></td>
		
		</tr>
			<%
			j++;
			}%>   -->
		
		<tr>
		<td><input type="submit" name="updateTitle<%=i%>" value="Update"></td>
		<td><input type="submit" name="deleteTitle<%=i%>" value="Delete"></td>
		</tr>




</table>
</div>
<%
				i++;
			}
			st.close();
		} catch (Exception e1) {
		}
	int k1=0;
	while(request.getParameter("deleteTitle"+k1) == null){
		k1++;
		if(k1>i)
			break;
	}
	if(request.getParameter("deleteTitle"+k1) != null){
		try{
			String nameOfButton = request.getParameter("deleteTitle"+k1);
			Statement st1 = con.createStatement();
			String serviceNumber = String.valueOf(k1);
			System.out.println("service number : " +serviceNumber);
			
			ResultSet rs2 = st1.executeQuery("SELECT * FROM `OpenServices` WHERE email='"+ email + "'");

			int k=0;
			String serviceId2="";
			while(rs2.next()){

				if(k==Integer.parseInt(serviceNumber)){
					serviceId = rs2.getInt(4);
					serviceId2 = Integer.toString(serviceId);
				System.out.println("service ID2 : " +serviceId2);
				}
				k++;
				//System.out.println("k: " +k);
			}
			/* System.out.println("buraya girdin mi?");
			//st1.executeUpdate("DELETE FROM `database2`.`OpenServices` WHERE `OpenServices`.`serviceId` = '"+ serviceId2 +"'");
			//int numberOfPlaceRows = st1.executeUpdate("DELETE FROM `database2`.`Place` WHERE `Place`.`serviceId` = '"+ serviceId2 +"'");
			st1.executeUpdate("DELETE FROM `database2`.`Tags` WHERE `Tags`.`serviceId` = '"+ serviceId2 +"'");
			*/
			%>
			<script type="text/javascript">
			location.reload(true);
			</script>
			<% 
			st1.close();
		}
		catch (Exception e2){
			e2.printStackTrace();
			System.out.println("hata");
		}
}
	int k2=0;
	while(request.getParameter("updateTitle"+k2) == null){
		k2++;
		if(k2>i)
			break;
}
	if(request.getParameter("updateTitle"+k2) != null){
		try{
			String nameOfButton = request.getParameter("updateTitle");
			Statement st1 = con.createStatement();
			String serviceNumber = String.valueOf(k2);
			System.out.println("service number for update : " +serviceNumber);
			
			ResultSet rs2 = st1.executeQuery("SELECT * FROM `OpenServices` WHERE email='"+ email + "'");
			
			int k=0;
			String serviceId2="";
			while(rs2.next()){

				if(k==Integer.parseInt(serviceNumber)){
					serviceId = rs2.getInt(4);
					serviceId2 = Integer.toString(serviceId);
				// System.out.println("update `OpenServices` set title='"+request.getParameter("titlebox")+"', description='"+description+
				// "',dateFrom='"+dateFrom+"', dateTo='" +dateTo+"' where serviceId="+k);
				
				//System.out.println("update `OpenServices` set title='"+request.getParameter("titlebox"+k)+"', description='"+request.getParameter("description"+k)+
				//"',dateFrom='"+request.getParameter("dateFromBox"+k)+"', dateTo='" +request.getParameter("dateToBox"+k)+"' where serviceId="+rs2.getString(4));
				
				st1.executeUpdate("update `OpenServices` set title='"+request.getParameter("titlebox"+k)+"', description='"+request.getParameter("description"+k)+
				"',dateFrom='"+request.getParameter("dateFromBox"+k)+"', dateTo='" +request.getParameter("dateToBox"+k)+"' where serviceId="+rs2.getString(4));
				
				
				/* int numberOfPlaceRows = st1.executeUpdate("DELETE FROM `database2`.`Place` WHERE `Place`.`serviceId` = '"+ serviceId2 +"'");
				System.out.println("number of places rows="+numberOfPlaceRows);
				 for(int m=0; m<numberOfPlaceRows; m++){
					st1.executeUpdate("INSERT INTO `database2`.`Place` (`serviceId`, `latitude`, `longtitude`, `radius`) VALUES ('"+ serviceId2 +"', '"+request.getParameter("latitudeBox"+k+"_"+m+"_0")+"', '"+request.getParameter("longitudeBox"+k+"_"+m+"_1")+"', '"+request.getParameter("radiusBox"+k+"_"+m+"_2")+"')");
				}*/
				 %>
				 <script type="text/javascript">
				 location.reload(true);
				 </script>
				 <%  
				st1.close();
		}
		k++;
		System.out.println("k for update: " +k);
	}

	} catch(Exception e2){
		e2.printStackTrace();
		System.out.println("hata update");
	}
}

} catch (Exception e) {
e.printStackTrace();
}


%>

</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Offered Services</title>
</head>
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
			int i = 0;
			String title="";
			String description="";
			int serviceId;
			String dateFrom="";
			String dateTo="";
			try {
				Statement st = con.createStatement();

				ResultSet rs = st
						.executeQuery("SELECT * FROM `OpenServices` WHERE email='"
								+ email + "'");
				
				while (rs.next()) {
					title = rs.getString(2);
					description = rs.getString(3);
					serviceId = rs.getInt(4);
					dateFrom = rs.getString(5);
					dateTo = rs.getString(6);
	%>

	<a href="showAppliers.jsp?value=<%=serviceId%>"><%=title %>
	</a>
	<br />
	<form action="OfferedServices.jsp" method="post">
	<table>
		<tr>
			<td>Title:</td>
			<td><input id="title" type="text" name="titlebox<%=i%>"
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
			<td><input type="text" name="dateFromBox<%=i%>"
				value="<%=dateFrom%>"></td>
			
		</tr>

		<tr>
			<td>Date To:</td>
			<td><input type="text" name="dateToBox<%=i%>" value="<%=dateTo%>"></td>
			
		</tr>
		
		<tr>
			<td><input type="submit" name="updateTitle<%=i%>" value="Update"></td>
			<td><input type="submit" name="deleteTitle<%=i%>" value="Delete"></td>
		</tr>
		
		    


	</table>
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
								System.out.println("k: " +k);
							}
							System.out.println("buraya girdin mi?");
							st1.executeUpdate("DELETE FROM `database2`.`OpenServices` WHERE `OpenServices`.`serviceId` = '"+ serviceId2 +"'");
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
					//	System.out.println("update `OpenServices` set title='"+request.getParameter("titlebox")+"', description='"+description+
					//			"',dateFrom='"+dateFrom+"', dateTo='" +dateTo+"' where serviceId="+k);
					
						System.out.println("update `OpenServices` set title='"+request.getParameter("titlebox"+k)+"', description='"+request.getParameter("description"+k)+
								"',dateFrom='"+request.getParameter("dateFromBox"+k)+"', dateTo='" +request.getParameter("dateToBox"+k)+"' where serviceId="+rs2.getString(4));
						st1.executeUpdate("update `OpenServices` set title='"+request.getParameter("titlebox"+k)+"', description='"+request.getParameter("description"+k)+
								"',dateFrom='"+request.getParameter("dateFromBox"+k)+"', dateTo='" +request.getParameter("dateToBox"+k)+"' where serviceId="+rs2.getString(4));
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
<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%!
			String encryptInteger(int number) {
				number *= 23;
				String str = Integer.toString(number);
				StringBuffer sb = new StringBuffer (str);
			      int lenStr = str.length();
			      // For each character in our string, encrypt it...
			      for ( int i = 0; i < lenStr; i++ ){ 
			         sb.setCharAt(i, (char)(str.charAt(i) +23)); 
			      }
			      return sb.toString();
			}
			%>
<body>
<%
	String applierApprovedString = request.getParameter("applierApproved");
	String serviceId = request.getParameter("serviceId");
	String applierId = request.getParameter("applierId");
	String update="";
	DBConnection db = new DBConnection();
	System.out.print("==>"+applierApprovedString+" "+serviceId+" "+applierId);
	int applierApproved = Integer.parseInt(applierApprovedString);
	if(applierApproved==0){
		update = "Update AcceptedServices Set serviceProviderApproved=1 where serviceId='"+serviceId+"' and email='"+applierId+"'";
		db.executeUpdate(update);
		db.closeConnection();
		
	}
	else{
		System.out.print("here");
		update = "DELETE FROM AcceptedServices WHERE serviceId='"+serviceId+"' and email='"+applierId+"'";
		db.executeUpdate(update);
		update = "INSERT INTO CompletedServices (email, serviceId) VALUES ('"+applierId+"',"+serviceId+")";
		db.closeConnection();
		db = new DBConnection();
		db.executeUpdate(update);
		System.out.println(update);
		db.closeConnection();
		db = new DBConnection();
		
		update = "SELECT demanderOrSupplier, email from OpenServices where serviceId='"+serviceId+"'";
		System.out.println(update);
		ResultSet rs = db.executeQuery(update);
		String type = null;
		String ownerName = null;
		if(rs.next()){
			type = rs.getString(1);
			ownerName = rs.getString(2);	
		}
		db.closeConnection();
		rs.close();
		System.out.println(type);
		//
		db = new DBConnection();
		update = "SELECT socialCredit from User where email='"+ownerName+"'";
		rs = db.executeQuery(update);
		int ownerCredit = -100;
		if(rs.next())
		 ownerCredit = rs.getInt(1);
		db.closeConnection();
		rs.close();
		//
		db = new DBConnection();
		update = "SELECT socialCredit from User where email='"+applierId+"'";
		rs = db.executeQuery(update);
		int applierCredit = -100;
		if(rs.next())
		 applierCredit = rs.getInt(1);
		db.closeConnection();
		rs.close();
		

		System.out.println("before:"+ownerCredit+" "+applierCredit);
		if(type.equals("supplier")){
			ownerCredit+=10;
			applierCredit-=10;
			System.out.println(ownerCredit+" "+applierCredit);
		}
		else if(type.equals("demander")){
			ownerCredit-=10;
			applierCredit+=10;
		}
		db = new DBConnection();
		update = "Update User Set socialCredit="+ownerCredit+" Where email='"+ownerName+"'";
		db.executeUpdate(update);
		db.closeConnection();
		db = new DBConnection();
		update = "Update User Set socialCredit="+applierCredit+" Where email='"+applierCredit+"'";
		db.executeUpdate(update);
		db.closeConnection();
			
	}
	response.sendRedirect("showAppliers.jsp?value="+encryptInteger(Integer.parseInt(serviceId)));
	//request.getRequestDispatcher("serviceCompleted.jsp").forward(request, response);
		
%>
<%=serviceId %>
<%=applierId %>
<%=update %>
</body>
</html>
<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
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
	}
	response.sendRedirect("showAppliers.jsp?value="+serviceId);
	//request.getRequestDispatcher("serviceCompleted.jsp").forward(request, response);
		
%>
<%=serviceId %>
<%=applierId %>
<%=update %>
</body>
</html>
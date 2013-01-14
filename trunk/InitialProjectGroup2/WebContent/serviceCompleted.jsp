<%@page import="com.group2.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*" import="java.util.*"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
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
<%
	String serviceProviderApprovedString = request.getParameter("serviceProviderApproved");
	String serviceId = request.getParameter("serviceId");
	String applierId = request.getParameter("applierId");
	String update="";
	DBConnection db = new DBConnection();
	System.out.print("==>"+serviceProviderApprovedString+" "+serviceId+" "+applierId);
	int serviceProviderApproved = Integer.parseInt(serviceProviderApprovedString);
	if(serviceProviderApproved==0){
		update = "Update AcceptedServices Set applierApproved=1 where serviceId='"+serviceId+"' and email='"+applierId+"'";
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
		
		
		if(type.equals("supplier")){
			ownerCredit+=10;
			applierCredit-=10;
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
		update = "Update User Set socialCredit="+applierCredit+" Where email='"+applierId+"'";
		db.executeUpdate(update);
		db.closeConnection();
		
	}
	response.sendRedirect("serviceStatus.jsp");
	//request.getRequestDispatcher("serviceCompleted.jsp").forward(request, response);
		
%>
<%=serviceProviderApproved %>
<%=serviceId %>
<%=applierId %>
<%=update %>
</body>
</html>
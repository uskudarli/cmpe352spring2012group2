<%@page import="java.sql.ResultSet"%>
<%@page import="com.group2.DBConnection"%>
<%@page import="java.util.Set"%>
<%@page import="com.group2.SearchQuery"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Result</title>
<link rel="stylesheet" type="text/css" href="./css/MyStyle.css">
</head>
<body>

<% 
	String tags=request.getParameter("tags");
	String startDate=request.getParameter("date_start");
	String endDate=request.getParameter("date_end");
	String gpsLocations=request.getParameter("gpsLocation");
	SearchQuery q=new SearchQuery();
	Set<Integer> resultList=q.getResults(tags, startDate, endDate, gpsLocations);
	if(resultList.size()==0){
		%>
		<p>No Results Found!</p>
		<%
	}
	else{
		DBConnection db=new DBConnection();
		ResultSet rs;
		ResultSet rs2;
		String query="SELECT * from OpenServices WHERE serviceId=";
		for(int id:resultList){
			rs=db.executeQuery(query+id);
			if(rs.next()){%>
				<ul>
					<li> <%=rs.getString(2) %> </li>
					<li> <%=rs.getString(3) %> </li>
					<li> <%=rs.getString(5) %> </li>
					<li> <%=rs.getString(6) %> </li>
				
				</ul>
			<%
			}
		}
	}
		
%>


</body>
</html>
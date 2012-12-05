<%@page import="com.group2.DBConnection"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body><% 
	String name = request.getParameter("name");
		String surname = request.getParameter("surname");
		String phone = request.getParameter("phone");
		String about = request.getParameter("about");
		String email = (String) request.getSession().getAttribute("email");
		about=URLEncoder.encode(about, "UTF-8");
		
		//about=about.replaceAll("'", "\\'");
		try {
			DBConnection dbConnection = new DBConnection();
			String update=("UPDATE User SET name='"+name+"', surname='"+surname+"', phone='"+phone+"', aboutMe='"+about+"' WHERE email='"+email+"'");
			dbConnection.executeUpdate(update);
			dbConnection.closeConnection();
			request.getRequestDispatcher("profile.jsp").forward(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	%>
</body>
</html>
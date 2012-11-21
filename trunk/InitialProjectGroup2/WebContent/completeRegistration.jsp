<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>
	<form action="Complete" method="post">
	<div >
		<b>Please provide necessary information to finish your registration.</b>
	<%
		if(session.getAttribute("name").equals("NULL)"))
			%>
				<br><b>Name</b><input type="text" name="name">
				
			<%
		if(session.getAttribute("surname").equals("NULL)"))
			%>
				<br><b>Surname</b><input type="text" name="surname">		
			<%
		if(session.getAttribute("phone").equals("NULL)"))
			%>
				<br><b>Mobile Phone</b><input type="text" name="phone">		
			<%
			
		if(session.getAttribute("about").equals(" "))			
			%>
				<br><b>About Me</b><textarea cols="25" rows="5" name="about">	</textarea>
				<br><br><input type="submit" value="Send">	
		
	</div>
	</form>
</body>
</html>
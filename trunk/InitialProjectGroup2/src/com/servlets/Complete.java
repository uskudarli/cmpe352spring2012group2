package com.servlets;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.group2.DBConnection;

/**
 * Servlet implementation class Complete
 */
@WebServlet("/Complete")
public class Complete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Complete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		
	}

}

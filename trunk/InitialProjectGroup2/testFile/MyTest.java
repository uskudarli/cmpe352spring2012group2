import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import org.apache.cactus.JspTestCase;
import org.apache.cactus.WebRequest;
import org.apache.cactus.WebResponse;

public class MyTest extends JspTestCase{
	
    public MyTest(String methodName) {
        super(methodName);
    }
    
	public void beginProfile(WebRequest request) {
		
		request.addParameter("username", "einstein@physicist.com");
		request.addParameter("password", "myPassword");
		request.addParameter("email", "test@file.co.uk");
		request.addParameter("name", "cemal");
		request.addParameter("surname", "ali");
		request.addParameter("credit", "30");
		request.addParameter("rating", "6.7");
		request.addParameter("phone", "05555555555");
		request.addParameter("about", "clever.");

	}

	public void testProfile() {
		
		RequestDispatcher rd = this.config.getServletContext().getRequestDispatcher("/profile.jsp");
        try {
			rd.forward(this.request, this.response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void endProfile(WebResponse response) {
		System.out.println("OK");
	}
	
	public void beginSearchResult(WebRequest request) {
		
		request.addParameter("tag", "lesson mathematics.");
		request.addParameter("date_start", "2012-12-19 19:45");
		request.addParameter("date_to", "2013-12-19 19:45");
		request.addParameter("gpsLocation", "11515");
		
	}

	public void testSearchResult() {
		
		RequestDispatcher rd = this.config.getServletContext().getRequestDispatcher("/profile.jsp");
        try {
			rd.forward(this.request, this.response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void endSearchResult(WebResponse response) {
		System.out.println("OK");
	}
	
	
	public void beginInsertRequest(WebRequest request) {
		
		request.addParameter("title", "Making bread");
		request.addParameter("description", "with gas water and flour");
		request.addParameter("tag", "lesson mathematics.");
		request.addParameter("date_start", "2012-12-19 19:45");
		request.addParameter("date_to", "2013-12-19 19:45");
		request.addParameter("gpsLocation", "11515");
		
	}

	public void testInsertRequest() {
		
		RequestDispatcher rd = this.config.getServletContext().getRequestDispatcher("/profile.jsp");
        try {
			rd.forward(this.request, this.response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void endInsertRequest(WebResponse response) {
		System.out.println("OK");
	}

	public void beginShowAppliers(WebRequest request) {
		
		request.addParameter("value", "95");
		
		
	}

	public void testShowAppliers() {
		
		RequestDispatcher rd = this.config.getServletContext().getRequestDispatcher("/profile.jsp");
        try {
			rd.forward(this.request, this.response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void endShowAppliers(WebResponse response) {
		System.out.println("OK");
	}
	
	public void beginAccept(WebRequest request) {
		
		request.addParameter("button", "submit");
	
	}

	public void testAccept() {
		
		RequestDispatcher rd = this.config.getServletContext().getRequestDispatcher("/profile.jsp");
        try {
			rd.forward(this.request, this.response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void endAccept(WebResponse response) {
		System.out.println("OK");
	}
	
	public void beginReject(WebRequest request) {
		
		request.addParameter("button", "submit");
		
		
	}

	public void testReject() {
		
		RequestDispatcher rd = this.config.getServletContext().getRequestDispatcher("/profile.jsp");
        try {
			rd.forward(this.request, this.response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void endReject(WebResponse response) {
		System.out.println("OK");
	}

}

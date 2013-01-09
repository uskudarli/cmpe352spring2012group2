package junitTest;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.junit.Test;

import com.group2.DBConnection;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;



public class UserTest {

//	@AfterClass
//	public static void tearDownAfterClass() throws Exception {
//	}
//
//	@Test
//	public void test() {
//		fail("Not yet implemented");
//	}
	
	@Test
	public void registerTest() throws Exception {
		String registerQuery = "INSERT INTO User(email, password, aboutMe) VALUES ('bahar2@gmail.com', 'password', ' ')";
		DBConnection dbConnection = new DBConnection();
		try{
			dbConnection.executeUpdate(registerQuery);
			System.out.println("success");
		}catch(MySQLIntegrityConstraintViolationException e1){
			System.out.println("This e-mail is already in use!");
		}catch(Exception e){
			System.out.println("An Error Occured.");
		}
		dbConnection.closeConnection();
	}
	

	@Test
	public void loginTest() {

		try {
			DBConnection db = new DBConnection();
			ResultSet rs= db.executeQuery("Select * from User where email='"+"einstein@physicist.com"+"'");
			if(rs.next() && rs.getString(2).equals("myPassword") ){
				
				String mail =rs.getString(1);
				String pass=rs.getString(2);
				String name=rs.getString(3);
				String surname=rs.getString(4);
				String credit=rs.getString(5);
				String rating=rs.getString(6);
				String phone=rs.getString(7);
				String about=rs.getString(8);
				String ratingCount = rs.getString(9);
				
				System.out.println("mail : " + mail + " pass : " + pass + " name : " + name + " surname : " + surname);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Test
	public void completeRegistrationTest() {

		try {
			DBConnection db = new DBConnection();
			ResultSet rs= db.executeQuery("Select * from User where email='"+"bahar2@gmail.com"+"'");
			if(rs.next() && rs.getString(2).equals("password") ){
				
				String mail =rs.getString(1);
				String pass=rs.getString(2);
				String name=rs.getString(3);
				String surname=rs.getString(4);
				String credit=rs.getString(5);
				String rating=rs.getString(6);
				String phone=rs.getString(7);
				String about=rs.getString(8);
				String ratingCount = rs.getString(9);
				
				System.out.println("mail : " + mail + " pass : " + pass + " name : " + name + " surname : " + surname);
				
				if(name.equals("") || surname.equals("") || name.equals("NULL") || surname.equals("NULL")) {
					try {
						DBConnection dbConnection = new DBConnection();
						String update=("UPDATE User SET name='"+"Bahar"+"', surname='"+"Soyad"+"', phone='"+"05556667788"+"', aboutMe='"+"aboutMe"+"' WHERE email='"+"bahar2@gmail.com"+"'");
						dbConnection.executeUpdate(update);
						dbConnection.closeConnection();
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

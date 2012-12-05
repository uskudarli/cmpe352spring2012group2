package com.group2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	private Connection connection = null;
	private Statement statement = null;
	private ResultSet resultSet = null;
	private final String URL = "jdbc:mysql://titan.cmpe.boun.edu.tr:3306/";
	private	String db = "database2";
	private String driver = "com.mysql.jdbc.Driver";
	private String userName ="project2";
	private String databasePassword="G6v0W7";
	public DBConnection() throws Exception{
		try { 
			Class.forName(driver);  
	        connection = DriverManager.getConnection(URL+db,userName,databasePassword);  
          
	      } catch (Exception e) {  
	          e.printStackTrace();  
	      }  
	}
	public ResultSet executeQuery(String query) throws SQLException{
		if(statement!=null && !statement.isClosed())
			statement.close();
		
		statement=connection.createStatement();
		return statement.executeQuery(query);
		
	}
	public void executeUpdate(String update)throws SQLException{
		if(statement!=null && !statement.isClosed())
			statement.close();
		statement=connection.createStatement();
		
		statement.executeUpdate(update);

		
	}
	public void closeConnection() throws SQLException{
		connection.close();
	}
}
	




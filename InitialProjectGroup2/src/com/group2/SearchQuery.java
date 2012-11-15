package com.group2;

import java.sql.ResultSet;
import java.util.HashSet;
import java.util.Set;

public class SearchQuery {
	public SearchQuery(){
		
	}
	public Set<Integer> getResults(String tags,String startDate,String endDate,String gpsLocations) throws Exception{
		Set <Integer> searchResults = new HashSet <Integer>();
		DBConnection db=new DBConnection();
		if(tags==null)
			tags="*";
		String[] tagList=tags.split("\\s+");
		
		String query="SELECT DISTINCT Tags.serviceId, OpenServices.dateFrom, OpenServices.dateTo "+
				"FROM OpenServices INNER JOIN Tags ON OpenServices.serviceId=Tags.serviceId WHERE Tags.tag='"+tagList[0]+"' ";
		for(int i=1;i<tagList.length;i++){
			query=query+"OR Tags.tag='"+tagList[i]+"' ";
		}
		System.out.println(query);
		ResultSet rs=db.executeQuery(query);
		
		while(rs.next()){
			int id=rs.getInt(1);
			String currentStart=rs.getString(2);
			String currentEnd=rs.getString(3);
			if(currentStart.compareTo(startDate)<0 && currentEnd.compareTo(startDate)<0){
				System.out.println(1);
			}
			else if(currentStart.compareTo(endDate)>0 && currentEnd.compareTo(endDate)>0){
				System.out.println(2);
			}
			else{ 
				searchResults.add(id);
			}
			
		}
		for(int i:searchResults){
			System.out.println(i);
		}
		return searchResults;
	}

}

package main;
import java.lang.Math;
import java.util.*;

public class main {

  //function for checking whether the input is prime or not
	public boolean isPrime(int x)
	{
		if (x<2)
			return false;
		if (x=2)
			return true;	
		//checking if x is dividible with numbers from 3 to Math.sqrt()			
		for (int i=3; i < Math.sqrt(x); i=i+2)
		{
			if (x%i==0)
				return false;
		}
		
		return true;
	}
	
}

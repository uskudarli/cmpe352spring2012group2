package main;
import java.lang.Math;
import java.util.*;

public class main {

	public boolean isPrime(int x)
	{
	if (x<2)
	return false;
		for (int i=2; i < Math.sqrt(x); i++)
		{
			if (x%i==0)
				return false;
		}
		
		return true;
	}
	
}

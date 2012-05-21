package main;
import java.util.*;

public class main {

	public boolean isPrime(int x)
	{
	if (x<2)
	return false;
		for (int i=2; i < sqrt(x); i++)
		{
			if (x%2==0)
				return false;
		}
		
		return true;
	}
	
}

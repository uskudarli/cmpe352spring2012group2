package main;

public class main {

	public boolean isPrime(int x)
	{
		for (int i=2; i < x; i++)
		{
			if (x%2==0)
				return false;
		}
		
		return true;
	}
	
}

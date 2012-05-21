package main;

import static org.junit.Assert.*;

import org.junit.Test;

public class mainTest {

	@Test
	public void testMult() {
		main tester = new main();
		assertEquals("Result", true, tester.isPrime(11));
	}

}

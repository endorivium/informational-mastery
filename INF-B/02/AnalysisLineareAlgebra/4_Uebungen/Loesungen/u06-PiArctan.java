public class PiArctan {

	// Approximation von pi = 4*arctan(1) durch 4*T_n(1),
	// T_n das Taylorpolynom vom Grad n=2m+1
	// Also:
	// pi = 4 * ( 1 -1/3 +1/5 -1/7 + ... +(-1)^m * 1/(2*m + 1) )
	public static double pi(int m) {

		// 1 -1/3 +1/5 -1/7 + ... +(-1)^m * 1/(2*m + 1)
		double sum = 0.0;

		for (int k = 0; k < m + 1; k++) {
			// Vorzeichen
			double sign = (k & 1) == 0 ? 1.0 : -1.0;

			sum += sign / (2 * k + 1);
		}
		
		// pi = 4 * sum
		return 4.0 * sum;
	}

	public static void main(String[] args) {

		for (int m = 0; m < 1000; m++) {

			double pi = pi(m); // Näherung von pi
			int n = 2 * m + 1; // Grad n des Taylorpolynoms
			double error = pi - Math.PI; // Fehler der Approximation
			boolean isErrorSmall = Math.abs(error) <= 0.001;

			System.out.println("m = " + m + " | pi ~ 4* T_" + n + " = " + pi + " | Fehler = " + error + " | Fehler<=0,001? "+ isErrorSmall);
		}
	}
}
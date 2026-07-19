public class Folgen {

	public static double a(int n) {

		if (n == 1) {
			return 1.0;
		} else if (n == 2) {
			return 2.0;
		} else if (n > 0) {
			return a(n - 1) * a(n - 2);
		} else {
			throw new IllegalArgumentException("n=" + n + " ist kleiner 1");
		}
	}

	public static void main(String[] args) {

		for (int n = 1; n < 100; n++) {

			System.out.println("n=" + n + ", a(n)=" + a(n));
		}

	}
}

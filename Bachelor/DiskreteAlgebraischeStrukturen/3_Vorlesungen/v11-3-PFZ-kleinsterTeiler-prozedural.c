#include <math.h>
#include <stdio.h>

int kleinsterTeilerErsteVersion(int n) {
	int d;
	// Suche kleinster Teiler d > 1, dieser ist eine Primzahl:
	for (d = 2; d <= n; ++d) {
		if (n % d == 0) {
			// d teilt n
			return d;
		}
	}

	// wird nie erreicht
	return -1;
}

int kleinsterTeiler(int n) {
	int d;
	// Suche kleinster Teiler d > 1, dieser ist eine Primzahl:
	for (d = 2; d <= sqrt(n); ++d) { // gehe nur bis sqrt(n)
		if (n % d == 0) {
			// d teilt n!
			return d;
		}
	}
	// hier d > sqrt(n) -> n muss Primzahl sein, d.h. kleinster Teil ist gleich Primzahl n selbst
	return n;
}

void printPFZ(int n) {
	printf ("%d = ", n);

	while (n != 1) {
		// Suche kleinster Teiler
		int d = kleinsterTeiler(n);
		// schlechtere Performance:
		// int d = kleinsterTeilerErsteVersion(n);

		printf("%d ", d);

		n = n / d;
	}

	printf("\n");
}

int main(void) {

	int n;

	for (n = 2; n < 100; ++n) {
		printPFZ(n);
	}

	printPFZ(1999939897);

	return 0;
}

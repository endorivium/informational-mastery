#include <stdio.h>
#include <math.h>

/*
 * Erste Version: Teste mit allen d <= n
 */
int isPrimeErsteVersion(int n) {
	for (int d = 2; d <= n; d++) {
		if (n%d == 0) {
			// d teilt n
			printf("d=%d | n=%d, keine Primzahl :'-(\n", d, n);
			return 0;
		} else {
			printf("d=%d teilt nicht n=%d, koennte noch Primzahl sein :-o\n", d, n);
		}
	}
	printf("n=%d ist eine Primzahl! :-)\n", n);
	return 1;
}

/*
 * Zweite Version: Teste mit allen d <= sqrt(n)
 */
int isPrimeZweiteVersion(int n) {
	for (int d = 2; d <= sqrt(n); d++) {
		if (n%d == 0) {
			// d teilt n
			printf("d=%d | n=%d, keine Primzahl :'-(\n", d, n);
			return 0;
		} else {
			printf("d=%d teilt nicht n=%d, koennte noch Primzahl sein :-o\n", d, n);
		}
	}
	printf("n=%d ist eine Primzahl! :-)\n", n);
	return 1;
}

// Liste der Primzahlen bis 409
int primes[] =
{    2,      3,      5,      7,     11,     13,     17,     19,     23,     29,
    31,     37,     41,     43,     47,     53,     59,     61,     67,     71,
    73,     79,     83,     89,     97,    101,    103,    107,    109,    113,
   127,    131,    137,    139,    149,    151,    157,    163,    167,    173,
   179,    181,    191,    193,    197,    199,    211,    223,    227,    229,
   233,    239,    241,    251,    257,    263,    269,    271,    277,    281,
   283,    293,    307,    311,    313,    317,    331,    337,    347,    349,
   353,    359,    367,    373,    379,    383,    389,    397,    401,    409};

/*
 * Dritte Version: Teste mit allen Primzahlen d <= sqrt(n)
 */
int isPrime(int n) {
	// Aufgepasst, man kann mit obiger Liste nur Zahlen n bis maximal 409*409 testen!
	// ggf. muss man die Liste oben erweitern!
	if (n > 409*409) {
		printf("Zahl n=%d muss kleiner gleich %d sein!\n", 409*409);
		return -1;
	}

	int i = 0;
	for (int d = primes[i]; d <= sqrt(n); d = primes[++i]) {
		if (n%d == 0) {
			// d teilt n
			printf("d=%d | n=%d, keine Primzahl :'-(\n", d, n);
			return 0;
		} else {
			printf("d=%d teilt nicht n=%d, koennte noch Primzahl sein :-o\n", d, n);
		}
	}
	printf("n=%d ist eine Primzahl! :-)\n", n);
	return 1;
}

int main(void) {

	puts("Primzahltest mit isPrimeErsteVersion");
	puts("====================================");

	int n = 76457;
	printf("Ist %d prim? %d\n", n, isPrimeErsteVersion(n));

	puts("\nPrimzahltest mit isPrime");
	puts("========================");
	printf("Ist %d prim? %d\n", n, isPrime(n));

	return 0;
}

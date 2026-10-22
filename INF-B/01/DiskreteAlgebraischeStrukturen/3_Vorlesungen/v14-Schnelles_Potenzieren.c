#include <stdio.h>
#include <stdlib.h>

int print_fast_power(int base, int power, int modulus) {

	if (power == 1) {
		printf("%d^%d = %d; (Ende Rekursion)\n", base, power, base);

		return base;
	} else {
		printf("%d^%d = ", base, power);

		// power = q * 2 + r
		int q = power / 2;
		int r = power % 2;

		printf("%d^(2 * %d + %d) = ", base, q, r);

		int base_2 = (base * base) % modulus;

		int factor = r == 0 ? 1 : base; // base^r mit r=0 oder r=1

		printf("%d^%d * %d (mod %d)\n", base_2, q, factor, modulus);

		// iteriere mit base = base_2 und power = q
		printf("Rekursion: ");
		int base_2_q = print_fast_power(base_2, q, modulus);

		printf("Loese Rekursion auf (* %d): %d * %d = ", factor, base_2_q,
				factor);

		int result = base_2_q * factor;
		int result_mod = result % modulus;

		printf("%d = %d (mod %d)\n", result, result_mod, modulus);

		return result_mod;
	}
}

int main(void) {
	puts("Algorithmus Schnelles Potenzieren");
	puts("=================================");

	int base = 2790;
	int power = 2753;
	int modulus = 3233;

	printf("\n%d^%d = ? (mod %d)\n\n", base, power, modulus);

	int result = print_fast_power(base, power, modulus);

	// print_fast_power(2, 11, 10);

	printf("\nERGEBNIS: %d^%d = %d (mod %d)", base, power, result, modulus);

	return EXIT_SUCCESS;
}

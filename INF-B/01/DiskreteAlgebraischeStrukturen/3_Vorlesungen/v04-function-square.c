#include <stdio.h>
#include <stdlib.h>

double square(double x) {
	return x*x;
}

int main(void) {
	puts("Parabel");
	puts("=======");

	puts("x      | square(x)");
	puts("------------------");

	double range = 99.0;

	for (double x = -range; x <= range; x = x+1) {
		printf("%6.2f |  %6.2f \n", x, square(x));
	}


	return EXIT_SUCCESS;
}

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double f(double x) {
	if (x >= 0) {
		return x;
	} else {
		return -x;
	}
}

double g(double x) {
	return 1 / (x * x - 1);
}

double h(double x) {
	return sqrt(x + 3);
}

int main(void) {

	double x;

	puts("Funktion f(x)=|x|");
	for (x = -5.0; x < 5.0; ++x) {
		printf("f(%f)=%f\n", x, f(x));
	}
	puts("");

	puts("Funktion g(x)= 1 / (x * x - 1)");
	for (x = -5.0; x < 5.0; ++x) {
		printf("g(%f)=%f\n", x, g(x));
	}
	puts("");

	puts("Funktion h(x)= sqrt(x + 3)");
	for (x = -3.0; x < 7.0; ++x) {
		printf("h(%f)=%f\n", x, h(x));
	}

	return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void) {
	puts("Umkehrfunktion von sin ist arcsin, d.h.");
	puts("  arcsin(sin(x))=x");
	puts("  sin(arcsin(x))=x\n");

	double x;

	// sin ist nur von -PI/2 bis PI/2 bijektiv!
	for (x = -M_PI_2; x <= M_PI_2; x=x+(M_PI/10)) {
		printf("x=%lf, sin(x)=%lf, arcsin(sin(x))=%lf\n", x, sin(x), asin(sin(x)));
	}

	// analog log/exp oder square/sqrt ...

	return EXIT_SUCCESS;
}

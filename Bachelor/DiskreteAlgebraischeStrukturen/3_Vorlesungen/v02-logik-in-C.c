#include <stdio.h>

int main(void) {

	// Beispiel Wahrheitswert in int:
	int a = 2;
	int isEven = !(a % 2);
	printf("Gerade? %d\n", isEven);

	// Aufgabe in Vorlesung: 5==4 && 3<4
	printf("5 gleich 4  ? %d\n", 5 == 4);
	printf("3 kleiner 4 ? %d\n", 3 < 4);
	printf("5 gleich 4, und 3 kleiner 4? %d\n", 5 == 4 && 3 < 4);

	// 10 ist wahr!
	if (10) {
		printf("wahr!");
	} else {
		printf("falsch!");
	}

	return 1;
}

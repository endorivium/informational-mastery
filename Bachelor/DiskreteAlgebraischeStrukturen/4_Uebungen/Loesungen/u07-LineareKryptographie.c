#include <stdio.h>
#include <string.h>

int main(void) {
	// Encryption
	char plainText[] = "informatik"; // {'i', 'n', 'f', ..., 'i', 'k', 0}

	for (int i = 0; plainText[i] != 0; ++i) {
		char letter = plainText[i]; // letter = a-z
		int x = letter - 'a'; // letter = a-z -> x = 0-25, dabei Zeichen 'a' = 0x61 = 97 (ASCII)
		int y = (3 * x + 2) % 26; // E(x)
		char c = y + 'a'; // 0-25 -> a-z
		printf("%c", c);
	}
	printf("\n");

	// Decryption
	char cypherText[] = "ismvkhob";

	for (int i = 0; cypherText[i] != 0; ++i) {
			char c = cypherText[i]; // c = a-z
			int y = c - 'a'; // c = a-z -> y = 0-25, dabei Zeichen 'a' = 0x61 = 97 (ASCII)
			int x = 9*(y+24) % 26; // D(y) (dabei -2 mod 26 = +24)
			char letter = x + 'a'; // x = 0-25 -> letter = a-z
			printf("%c", letter);
		}
}

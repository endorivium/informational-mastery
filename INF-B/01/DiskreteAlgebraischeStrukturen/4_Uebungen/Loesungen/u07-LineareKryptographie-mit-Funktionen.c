#include <stdio.h>
#include <string.h>

// Codierung von a-z -> 0-25
int encode(char letter) {
	return letter - 'a'; // nach ASCII-Code ist Zeichen 'a' = 0x61 = 97
}

// Decodierung von 0-25 -> a-z
char decode(int x) {
	return x + 'a'; // nach ASCII-Code ist Zeichen 'a' = 0x61 = 97
}

// Encryption von x (als Zahl)
int E(int x) {
	return (3 * x + 2) % 26;
}

// Decryption von y (als Zahl)
int D(int y) {
	return (9 * (y + 24)) % 26; // -2 mod 26 = +24
}

// Print Encryption von String plainText
void printEncryption(char plainText[]) {
	printf("Encryption: %s -> ", plainText);
	for (int i = 0; i < strlen(plainText); ++i) {
		char letter = plainText[i];
		int x = encode(letter);
		int y = E(x);
		printf("%c", decode(y));
	}
	printf("\n");
}

// Print Encryption von String cypherText
void printDecryption(char cypherText[]) {
	printf("Decryption: %s -> ", cypherText);
	for (int i = 0; i < strlen(cypherText); ++i) {
		char letter = cypherText[i];
		int y = encode(letter);
		int x = D(y);
		printf("%c", decode(x));
	}
	printf("\n");
}

int main(void) {
	// Ausgabe a-z:
	printf("a-z      |");
	char letter = 'a'; // nach ASCII-Code ist Zeichen 'a' = 0x61 = 97
	for (int i = 0; i < 26; ++i) {
		printf("%c  ", letter + i);
	}
	printf("\n");

	// Ausgabe 0-25:
	printf("x        |");
	for (int x = 0; x < 26; ++x) {
		printf("%02d ", x);
	}
	printf("\n");

	// Ausgabe von E(0)-E(25):
	printf("y = E(x) |");
	for (int x = 0; x < 26; ++x) {
		printf("%02d ", E(x));
	}
	printf("\n");

	// Ausgabe von E(0)-E(25):
	printf("a-z      |");
	for (int x = 0; x < 26; ++x) {
		printf("%c  ", decode(E(x)));
	}
	printf("\n");
	printf("\n");

	// ganzen String Ver-/Entschlüsseln:
	char plainText[] = "informatik"; // {'i', 'n', 'f', ..., 'i', 'k', 0}
	printEncryption(plainText);

	char cypherText[] = "ismvkhob";
	printDecryption(cypherText);
}

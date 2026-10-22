package main

import (
	"fmt"
	"testing"
)

func TestStream(t *testing.T) {
	toUpperCase := func(input string) string {
		convertedString := make([]rune, 0)
		for _, r := range []rune(input) {
			if r >= 97 && r <= 122 {
				convertedString = append(convertedString, r-32)
			} else {
				convertedString = append(convertedString, r)
			}
		}
		return string(convertedString)
	}

	notDigit := func(input string) bool {
		for _, r := range input {
			if r >= 49 && r <= 57 {
				return false
			}
		}
		return true
	}
	concat := func(a string, b string) string {
		return a + "," + b
	}

	stringSlice := []string{"a", "b", "c", "1", "D"}

	// Map/Reduce
	result := ToStream(stringSlice).
		Map(toUpperCase).
		Filter(notDigit).
		Reduce(concat)

	if result != "A,B,C,D" {
		t.Error(fmt.Sprintf("Result should be 'A,B,C,D' but is: %v", result))
	}
}

package main

import "testing"

func SwapTest(t *testing.T) {
	var a, b int = 2, 5
	var expectedA, expectedB int = 5, 2

	//swap0 test
	a, b = swap0(a, b)
	if a != expectedA && b != expectedB {
		t.Error("Variable 'a' and 'b' should be ", expectedA, " and ", expectedB, " but is ", a, " and ", b)
	}

	//swap1 test
	swap1(&a, &b)
	if a != expectedA && b != expectedB {
		t.Error("Variable 'a' and 'b' should be ", expectedA, " and ", expectedB, " but is ", a, " and ", b)
	}

}

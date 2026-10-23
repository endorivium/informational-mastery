package main

import "fmt"

func main() {
	fmt.Println("Hello World")

	//simple swap with return
	var a, b int
	a = 5
	b = 2
	fmt.Println("Initial values: a|", a, " b|", b)
	a, b = swap0(a, b)
	fmt.Println("Swapped numbers: a|", a, " b|", b)

	//pointer swap
	swap1(&a, &b)
	fmt.Println("Swapped numbers: a|", a, " b|", b)
}

// variable types are declared after the name
// data types in () declare what is returned, can return multiple
func swap0(x int, y int) (int, int) {
	return y, x //swap occurs by simply returning the variables with swapped position
}

func swap1(x *int, y *int) {
	*x, *y = *y, *x //values are swapped by swapping their pointers
}

package main

import "fmt"

func Filter(array []string, f func(string) bool) []string {
	filteredArray := make([]string, 0)
	for _, v := range array {
		if f(v) {
			filteredArray = append(filteredArray, v)
		}
	}
	return filteredArray
}

func Map(array []string, f func(string) string) []string {
	for i := range array {
		array[i] = f(array[i])
	}
	return array
}

func Reduce(array []string, f func(a, b string) string) string {
	var reducedString string = array[0]
	for i := 1; i < len(array); i++ {
		reducedString = f(reducedString, array[i])
	}
	return reducedString
}

// https://medium.com/@yazeedb/implement-array-reduce-with-recursion-7a854409ac44
func ReduceWithRecursion(array []string, f func(a, b string) string) []string {
	if len(array) == 1 {
		return array
	}

	array[1] = f(array[0], array[1])
	return ReduceWithRecursion(array[1:], f)
}

func main() {
	notDigit := func(input string) bool {
		for _, r := range input {
			if r >= 49 && r <= 57 {
				return false
			}
		}
		return true
	}
	array := []string{"a", "1234567890", "c", "12", "D"}
	result := Filter(array, notDigit)
	fmt.Println(result) // "a", "c", "D"

	toUppercase := func(input string) string {
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

	toLowercase := func(input string) string {
		convertedString := make([]rune, 0)
		for _, r := range []rune(input) {
			if r >= 65 && r <= 90 {
				convertedString = append(convertedString, r+32)
			} else {
				convertedString = append(convertedString, r)
			}
		}
		return string(convertedString)
	}

	arrayUpper := []string{"eVeRyThInG", "uPpErCaSe"}
	resultUpper := Map(arrayUpper, toUppercase)
	fmt.Println(resultUpper) // "EVERYTHING", "UPPERCASE"

	arrayLower := []string{"eVeRyThInG", "lOWeRcAsE"}
	resultLower := Map(arrayLower, toLowercase)
	fmt.Println(resultLower) // "EVERYTHING", "UPPERCASE"

	concat := func(a string, b string) string {
		return a + "," + b
	}
	arrayReduce := []string{"a", "b", "c", "d"}
	resultReduce := ReduceWithRecursion(arrayReduce, concat)
	fmt.Println(resultReduce) // "a,b,c,d"
}

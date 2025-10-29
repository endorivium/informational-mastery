package main

import "fmt"

func Filter(array []string, f func(string) bool) []string {
	for i, v := range array {
	if(f(v)){

	}
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
}

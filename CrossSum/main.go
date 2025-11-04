package main

import (
	"fmt"
)

func calculateCrossSum(num int) int {
	var decimals int = 0
	var numCopy int = num
	for i := 0; numCopy >= 1; i++ {
		numCopy /= 10
		decimals++
	}
	fmt.Println("how many decimals: ", decimals)

	var crossSum int = 0
	var modulo int = 10
	var currentDecimal int = 0
	var prevDecimal int = 0
	for i := 1; prevDecimal != num; i++ {
		if modulo == 10 {
			currentDecimal = num % modulo
		} else {
			currentDecimal = ((num % modulo) - prevDecimal) / (modulo / 10)
		}

		crossSum = crossSum + currentDecimal
		prevDecimal = num % modulo
		fmt.Println("prevDecimal: ", prevDecimal, " | Current decimal: ", currentDecimal, " | Current cross sum: ", crossSum, " | Num: ", num)
		modulo *= 10
	}
	return crossSum
}

func calcCrossSum(num int) int {
	var crossSum int = 0

	for i := 0; num != 0; i++ {
		crossSum = crossSum + num%10
		num = num / 10
		fmt.Println("cross sum: ", crossSum, " | num: ", num)
	}
	return crossSum
}

func main() {
	fmt.Println(calculateCrossSum(1568))
	fmt.Println(calcCrossSum(1568))
}

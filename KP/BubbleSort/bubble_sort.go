package main

import (
	"fmt"
)

func BubbleSort(data []int, f func(i, j int) bool) {
	for i := 0; i < len(data); i++ {
		for j := 0; j < len(data)-1; j++ {
			if f(j, j+1) {
				data[j], data[j+1] = data[j+1], data[j] // Swap the values
			}
		}
	}
}

func BubbleSortWithoutFuncParam(data []int) {
	for i := 0; i < len(data); i++ {
		for j := 0; j < len(data)-1; j++ {
			if data[j] > data[j+1] {
				data[j], data[j+1] = data[j+1], data[j] // Swap the values
			}
		}
	}
}

func main() {
	data := []int{27, 15, 8, 9, 12, 4, 17, 19, 21, 23, 25}
	//BubbleSortWithoutFuncParam(data)
	BubbleSort(data, func(i, j int) bool { return data[i] < data[j] })
	fmt.Println(data)
}

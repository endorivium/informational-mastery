package main

import "fmt"

//import "fmt"

type Streamer interface {
	Map(m Mapper) Stream
	Filter(p Predicate) Stream
	Reduce(a Accumulator) any
}

type Stream struct {
	array []string
}

func ToStream(array []string) Stream {
	return Stream{array}
}

type Mapper func(string) string

type Predicate func(string) bool

type Accumulator func(a, b string) string

func (str Stream) Filter(p Predicate) Stream {
	filteredArray := make([]string, 0)
	for _, v := range str.array {
		if p(v) {
			filteredArray = append(filteredArray, v)
		}
	}
	return Stream{filteredArray}
}

func (str Stream) Map(m Mapper) Stream {
	for i := range str.array {
		str.array[i] = m(str.array[i])
	}
	return str
}

func (str Stream) Reduce(a Accumulator) any {
	if len(str.array) == 1 {
		return str.array[0]
	}

	str.array[1] = a(str.array[0], str.array[1])
	str.array = str.array[1:]
	return str.Reduce(a)
}

func main() {
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

	fmt.Println(result)
}

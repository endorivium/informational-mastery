package main

import "fmt"

//import "fmt"

type Streamer interface {
	Map(m Mapper) Stream
	Filter(p Predicate) Stream
	Reduce(a Accumulator) any
}

type Stream []any

func ToStream(array []any) Stream {
	stream := make(Stream, 0)

	for _, v := range array {
		stream = append(stream, v)
	}
	return stream
}

// Mapper function maps a value to another value.
type Mapper func(any) any

// Predicate function returns true if a given element should be filtered.
type Predicate func(any) bool

// Accumulator function returns a combined element.
type Accumulator func(a any, b any) any

func (str Stream) Filter(p Predicate) Stream {
	filteredArray := make([]any, 0)
	for _, v := range str {
		if p(v) {
			filteredArray = append(filteredArray, v)
		}
	}
	return filteredArray
}

func (str Stream) Map(m Mapper) Stream {
	for i := range str {
		str[i] = m(str[i])
	}
	return str
}

func (str Stream) Reduce(a Accumulator) any {
	if len(str) == 1 {
		return str[0]
	}

	str[1] = a(str[0], str[1])
	return str[1:].Reduce(a)
}

func main() {
	toUpperCase := func(input any) any {
		convertedString := make([]rune, 0)
		for _, r := range []rune(input.(string)) {
			if r >= 97 && r <= 122 {
				convertedString = append(convertedString, r-32)
			} else {
				convertedString = append(convertedString, r)
			}
		}
		return string(convertedString)
	}

	notDigit := func(input any) bool {
		for _, r := range input.(string) {
			if r >= 49 && r <= 57 {
				return false
			}
		}
		return true
	}

	concat := func(a any, b any) any {
		return a.(string) + "," + b.(string)
	}

	stringSlice := []any{"a", "b", "c", "1", "D"}

	fmt.Println(stringSlice[0].(string) + "," + stringSlice[1].(string))

	// Map/Reduce
	result := ToStream(stringSlice).
		Map(toUpperCase).
		Filter(notDigit).Reduce(concat)

	fmt.Println(result) //output: A,B,C,D
}

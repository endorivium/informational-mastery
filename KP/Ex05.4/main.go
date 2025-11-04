package main

import "fmt"

//import "fmt"

type Streamer interface {
	Map(m Mapper) Stream
	Filter(p Predicate) Stream
	Reduce(a Accumulator) any
}

type Stream []any

type WordCountPair struct {
	word  string
	count int
}

func ToStream(array []any) Stream {
	stream := make(Stream, 0)

	for _, v := range array {
		stream = append(stream, v)
	}
	return stream
}

type Mapper func(any) any

type Predicate func(any) bool

type Accumulator func(a any, b any) any

func (str Stream) Filter(p Predicate) Stream {
	filteredArray := make([]any, 0)
	for _, v := range str {
		if p(v) {
			filteredArray = append(filteredArray, v)
		}
	}
	return Stream{filteredArray}
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
	wordCount := []any{"a", "a", "b", "b", "D", "a", "c", "a", "c", "D", "D"}

	toWordCountPair := func(o any) any {
		if v, ok := o.(string); ok {
			result := []WordCountPair{{v, 1}}
			return result
		}
		return o
	}

	/*
		inputs are WordCountPair array with one entry
		when summing up, check if the word of b is same as a
		if yes, then increment a
		if no, then add new entry to array
	*/
	sumInts := func(a any, b any) any {
		var arr []WordCountPair
		if arrA, okA := a.([]WordCountPair); okA {
			arr = arrA
			if arrB, okB := b.([]WordCountPair); okB {
				var notIndexed bool = true
				for i, v := range arrA {
					if v.word == arrB[0].word {
						arr[i].count++
						notIndexed = false
					}
				}
				if notIndexed {
					arr = append(arr, arrB[0])
				}
			}
		}
		return arr
	}

	wordCountStream := ToStream(wordCount).Map(toWordCountPair).Reduce(sumInts)

	if stream, ok := wordCountStream.([]WordCountPair); ok {
		for _, v := range stream {
			fmt.Printf("%v:%v ", v.word, v.count)
		}
	}
}

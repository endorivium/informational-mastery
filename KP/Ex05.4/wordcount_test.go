package main

import (
	"fmt"
	"testing"
)

func TestWordcount(t *testing.T) {
	wordCount := []any{"a", "ac", "b", "b", "D", "a", "ac", "a", "c", "D", "D"}

	toWordCountPair := func(o any) any {
		if v, ok := o.(string); ok {
			result := []WordCountPair{{v, 1}}
			return result
		}
		return o
	}

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

	result := ToStream(wordCount).Map(toWordCountPair).Reduce(sumInts)

	//"a", "ac", "b", "b", "D", "a", "ac", "a", "c", "D", "D"
	check := []WordCountPair{{"a", 3}, {"ac", 2},
		{"b", 2}, {"D", 3},
		{"c", 1}}

	if stream, ok := result.([]WordCountPair); ok {
		if len(stream) > len(check) || len(stream) < len(check) {
			t.Error(fmt.Sprintf("Result should have %v entries but has %v instead", len(check), len(stream)))
		}

		for i, v := range stream {
			if v.word != check[i].word {
				t.Error(fmt.Sprintf("Current result entry should have the word %v but is %v instead.", check[i].word, v.word))
			}

			if v.count != check[i].count {
				t.Error(fmt.Sprintf("Current result entry should have the word count %v but is %v instead.", check[i].count, v.count))
			}
		}
	}
}

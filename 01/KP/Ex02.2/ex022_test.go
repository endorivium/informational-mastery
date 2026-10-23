package main

import (
	"testing"
)

func TestBookIndex(t *testing.T) {
	var murderbotDiaries Book
	murderbotDiaries = Book{
		Page{"I", "could", "have", "become", "a", "mass", "murderer", "after", "I", "hacked", "my", "governor", "module"},
		Page{"As", "a", "heartless", "killing", "machine", "I", "was", "a", "failure"},
		Page{"Conflicting", "commands", "filled", "my", "feed", "but", "I", "did not", "pay", "attention"}}

	targetWord := "I"
	murderbotBookIndex := MakeBookIndex(murderbotDiaries)

	if _, check := murderbotBookIndex[targetWord]; check {
		pages := murderbotBookIndex[targetWord]
		for i := 0; i < len(pages); i++ { //iterate through found book indexes
			var bWordFound bool = false
			for j := 0; j < len(murderbotDiaries[pages[i]]); j++ { //iterate through page in book according to found index
				if murderbotDiaries[pages[i]][j] == targetWord {
					bWordFound = true
				}
			}
			if !bWordFound {
				t.Error("The word ", targetWord, " was not found in the book index. \n")
			}
		}
	} else {
		t.Error("The target word ", targetWord, " was not found in the book index.\n")
	}
}

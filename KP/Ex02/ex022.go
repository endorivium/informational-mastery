package main

import "fmt"

type Book []Page
type Page []string
type Index []int

var murderbotDiaries Book

func MakeBookIndex(book Book) (bookIndex map[string]Index) {
	bookIndex = make(map[string]Index)
	for pageIndex := 0; pageIndex < len(book); pageIndex++ {
		for wordIndex := 0; wordIndex < len(book[pageIndex]); wordIndex++ {
			if _, check := bookIndex[book[pageIndex][wordIndex]]; check {
				bookIndex[book[pageIndex][wordIndex]] =
					append(bookIndex[book[pageIndex][wordIndex]], pageIndex)
			} else {
				bookIndex[book[pageIndex][wordIndex]] = Index{pageIndex}
			}
		}
	}
	return bookIndex
}

func main() {
	murderbotDiaries = Book{
		Page{"I", "could", "have", "become", "a", "mass", "murderer", "after", "I", "hacked", "my", "governor", "module"},
		Page{"As", "a", "heartless", "killing", "machine", "I", "was", "a", "failure"},
		Page{"Conflicting", "commands", "filled", "my", "feed", "but", "I", "did not", "pay", "attention"}}

	murderbotIndex := MakeBookIndex(murderbotDiaries)
	fmt.Print(murderbotIndex["commands"])
}

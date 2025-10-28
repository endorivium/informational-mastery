package main

type Book []Page
type Page []string
type Index map[string][]int

//alt make Book and Page structs

func MakeBookIndex(book Book) (bookIndex map[string][]int) {
	bookIndex = make(map[string][]int)
	for pageIndex := 0; pageIndex < len(book); pageIndex++ {
		for wordIndex := 0; wordIndex < len(book[pageIndex]); wordIndex++ {
			if _, check := bookIndex[book[pageIndex][wordIndex]]; check {
				bookIndex[book[pageIndex][wordIndex]] =
					append(bookIndex[book[pageIndex][wordIndex]], pageIndex)
			} else {
				bookIndex[book[pageIndex][wordIndex]] = []int{pageIndex}
			}
		}
	}
	return bookIndex
}

//MakePage()
//MakeBook()

func main() {

}

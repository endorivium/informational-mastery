package main

import "fmt"

type Greeter interface {
	Greet(name string)
}

type Base struct {
}

func (b Base) Greet(name string) {
	fmt.Println("Hello " + name)
}

type Derived struct {
	Base
}

func (d Derived) Greet(name string) {
	fmt.Println("Greetings " + name)
}

func main() {
	hellos := []Greeter{Base{}, Derived{}}

	for _, hello := range hellos {
		hello.Greet("World!")
	}
}

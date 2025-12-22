package main

import (
	"fmt"
	"strconv"
	"strings"
)

type Stack struct {
	data []int
}

type Stacker interface {
	Push(obj int)
	Pop()
}

func (s *Stack) Push(value int) {
	s.data = append(s.data, value)
}

func (s *Stack) Pop() int {
	if len(s.data) == 0 {
		panic("can not pop: empty stack")
	}
	var result = s.data[len(s.data)-1]
	s.data = s.data[0 : len(s.data)-1]
	return result
}

func main() {
	var s Stack
	fields := strings.Fields("2 3 5 * +")
	for _, expr := range fields {
		fmt.Println("Parse ", expr)
		switch expr {
		case "+":
			s.Push(s.Pop() + s.Pop())
		case "*":
			s.Push(s.Pop() * s.Pop())
		default:
			v, err := strconv.Atoi(expr)
			if err != nil {
				fmt.Println("Unknown expr", expr)
				return
			}
			s.Push(v)
		}
	}
	println("result:", s.Pop())
}

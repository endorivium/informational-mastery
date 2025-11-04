package main

import (
	"fmt"
	"math/rand/v2"
)

type Stack []any

type Painter interface {
	Paint()
}

type Stacker interface {
	Push(obj any)
	Pop()
}

func (arr *Stack) Push(obj any) {
	*arr = append(*arr, obj) //dereference arr to access value of array
}

func (arr *Stack) Pop() {
	*arr = (*arr)[:len(*arr)-1] //dereference arr and cast
}

type Position struct {
	X, Y float64
}

type GeoObject struct {
	Pos   Position
	Color string
}

type Circle struct {
	ObjInfo GeoObject
	Radius  float64
}

func (c Circle) Paint() {
	fmt.Println("This Circle has the following attributes: "+
		"\n - AnchorPosition: ", c.ObjInfo.Pos, "\n - Color: ", c.ObjInfo.Color, "\n - Radius: ", c.Radius)
}

func MakeRandomCircleObj() (c Circle) {
	c.ObjInfo = GeoObject{Pos: Position{X: rand.Float64() * 10, Y: rand.Float64() * 10}, Color: "green"}
	c.Radius = rand.Float64() * 10
	return
}

type Rectangle struct {
	ObjInfo       GeoObject
	Width, Height float64
}

func (r Rectangle) Paint() {
	fmt.Println("This Rectangle has the following attributes: "+
		"\n - AnchorPosition: ", r.ObjInfo.Pos, "\n - Color: ", r.ObjInfo.Color, "\n - Width/Height: ", r.Width, "/", r.Height)
}

func MakeRandomRectangleObj() (r Rectangle) {
	r.ObjInfo = GeoObject{Pos: Position{X: rand.Float64() * 10, Y: rand.Float64() * 10}, Color: "yellow"}
	r.Width = rand.Float64() * 10
	r.Height = rand.Float64() * 10
	return
}

type Triangle struct {
	ObjInfo GeoObject
	B, C    Position
}

func (t Triangle) Paint() {
	fmt.Println("This Triangle has the following attributes: "+
		"\n - Position: ", t.ObjInfo.Pos, "\n - Color: ", t.ObjInfo.Color, "\n - B/C: ", t.B, " / ", t.C)
}

func MakeRandomTriangleObj() (t Triangle) {
	t.ObjInfo = GeoObject{Pos: Position{X: rand.Float64() * 10, Y: rand.Float64() * 10}, Color: "red"}
	t.B = Position{X: rand.Float64() * 10, Y: rand.Float64() * 10}
	t.C = Position{X: rand.Float64() * 10, Y: rand.Float64() * 10}
	return
}

func main() {
	var circleObj Circle = Circle{GeoObject{Position{5, 10}, "green"}, 5}
	var rectangleObj Rectangle = Rectangle{GeoObject{Position{4, 7}, "yellow"}, 3, 5}
	var triangleObj Triangle = Triangle{GeoObject{Position{11, 9}, "red"},
		Position{4, 12}, Position{5, 10}}

	circleObj.Paint()
	rectangleObj.Paint()
	triangleObj.Paint()

	geoObjs := []Painter{MakeRandomCircleObj(), MakeRandomTriangleObj(), MakeRandomRectangleObj()}

	fmt.Println("\n The geoObjs array has the following entries:")
	for _, obj := range geoObjs {
		obj.Paint()
	}

	var nums Stack = Stack{0, 1, 2, 3}
	nums.Push(4)
	fmt.Println("The nums stack has the following entries:", nums)
	nums.Pop()
	fmt.Println("The nums stack has the following entries:", nums)
}

package main

import (
	"fmt"
	"time"
)

func setTimeout(f func() int, timeout time.Duration) (int, error) {
	c := make(chan int)
	c <- f()
	select {
	case <-time.After(timeout):
		return 0, fmt.Errorf("timed out")
	}
}

func main() {
	res, err := setTimeout(func() int {
		time.Sleep(2000 * time.Millisecond)
		return 1
	}, 1*time.Second)

	if err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Printf("operation returned %d", res)
	}
}

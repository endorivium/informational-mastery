package main

import (
	"fmt"
	"time"
)

func setTimeout(task func() int, timeout time.Duration) (int, error) {
	taskChan := make(chan int, 1)
	go func() { //coroutine task function
		taskChan <- task() //send task to channel
	}()
	select { //will execute case that finishes first
	case res := <-taskChan:
		return res, nil
	case <-time.After(timeout):
		return 0, fmt.Errorf("operation timed out after %d seconds", timeout/1000000000)
	}
}

func main() {
	res, err := setTimeout(func() int {
		time.Sleep(1 * time.Second)
		return 1
	}, 1*time.Second)

	if err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Printf("operation returned %d", res)
	}
}

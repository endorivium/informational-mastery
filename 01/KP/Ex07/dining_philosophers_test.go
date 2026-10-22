package philosophers

import (
	"fmt"
	"testing"
	"time"
)

func TestPhilosophers(t *testing.T) {

	var COUNT = 5

	// start table for 5 philosophers
	table := NewTable(COUNT)

	philosophers := make([]Philosopher, COUNT)
	// create 5 philosophers and run parallel
	for i := 0; i < COUNT; i++ {
		philosopher := NewPhilosopher(i, table)
		philosophers[i] = philosopher
		go philosophers[i].run()
	}

	// simulate 10 milliseconds --> check output
	time.Sleep(100 * time.Millisecond)

	fmt.Println("---------------------")
	for _, v := range philosophers {
		fmt.Printf("Philosopher #%d has eaten %d times\n", v.tableSeat, v.timesEaten)
	}
}

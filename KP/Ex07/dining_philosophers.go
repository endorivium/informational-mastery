package philosophers

import (
	"fmt"
	"time"
)

type Philosopher struct {
	tableSeat  int
	table      Table
	rightFork  int
	leftFork   int
	gotForks   bool
	timesEaten int
}

func NewPhilosopher(seatIndex int, table Table) Philosopher {
	var rightFork int
	var leftFork int

	//assign index of right fork
	rightFork = seatIndex

	//assign index of left fork
	if seatIndex == table.tableSize-1 {
		leftFork = 0
	} else {
		leftFork = seatIndex + 1
	}

	return Philosopher{seatIndex, table, rightFork, leftFork, false, 0}
}

func (p *Philosopher) run() {
	for {
		p.takeForks()
		p.eat()
		p.putForks()
		p.think()
	}
}

func (p *Philosopher) eat() {
	fmt.Printf("[->] Philosopher #%d eats...\n", p.tableSeat)
	time.Sleep(10 * time.Millisecond)
	fmt.Printf("[<-] Philosopher #%d eat ends.\n", p.tableSeat)
	p.timesEaten++
}

func (p *Philosopher) takeForks() {
	select {
	case <-p.table.forkAvailability[p.rightFork]:
		//fmt.Printf("[->] Philosopher #%d takes right fork...\n", p.tableSeat)
		select {
		case <-p.table.forkAvailability[p.leftFork]:
			fmt.Printf("[->] Philosopher #%d takes forks %d|%d...\n", p.tableSeat, p.rightFork, p.leftFork)
		}
	}
}

func (p *Philosopher) putForks() {
	fmt.Printf("[->] Philosopher #%d returns forks %d|%d...\n", p.tableSeat, p.rightFork, p.leftFork)
	p.table.forkAvailability[p.rightFork] <- true
	p.table.forkAvailability[p.leftFork] <- true
}

func (p *Philosopher) think() {
	fmt.Printf("[->] Philosopher #%d thinks...\n", p.tableSeat)
	time.Sleep(30 * time.Millisecond)
	fmt.Printf("[<-] Philosopher #%d thinking ends.\n", p.tableSeat)
}

// Table order is fork philosopher, meaning forkAvailability[0] is the right fork of the first philosopher
type Table struct {
	tableSize        int
	forkAvailability []chan bool
}

func NewTable(numAttendees int) Table {
	table := Table{}
	table.tableSize = numAttendees
	table.forkAvailability = make([]chan bool, numAttendees)

	for i := 0; i < numAttendees; i++ {
		table.forkAvailability[i] = make(chan bool, 1)
		table.forkAvailability[i] <- true
	}

	return table
}

package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"net/http"
)

type NodeState int

const (
	Follower NodeState = iota
	Candidate
	Leader
)

var nodePortList = []string{
	"10000", "10001", "10002",
}

func switchState() {

}

func HandleNotFound(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusNotFound)
	fmt.Fprintf(w, "Nothing to see here\n")
}

func EchoParameters(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	data, _ := json.Marshal(r.URL.Query())
	w.Write(data)
}

func main() {
	var node0 = flag.Int("node0", 2, "army 0")
	var node1 = flag.Int("node1", 0, "army 1")
	var node2 = flag.Int("node2", 0, "army 2")
	flag.Parse()
	fmt.Println("you entered: ", *node0)
	fmt.Println("you entered: ", *node1)
	fmt.Println("you entered: ", *node2)

	http.HandleFunc("/", HandleNotFound)
	http.HandleFunc("/api/echoParams", EchoParameters)
	log.Fatal(http.ListenAndServe(":"+nodePortList[0], nil))

}

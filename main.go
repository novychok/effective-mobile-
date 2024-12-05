package main

import (
	"fmt"
	"math/rand"
	"net/http"
)

const ServerPort = "1333"

func main() {

	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		switch 1 + rand.Intn(2) {
		case 1:
			w.WriteHeader(http.StatusOK)
			fmt.Fprintln(w, "Server is healthy")
		case 2:
			w.WriteHeader(http.StatusInternalServerError)
			fmt.Fprintln(w, "Internal Server Error")
		}
	})

	fmt.Printf("server has started on port :%s\n", ServerPort)

	if err := http.ListenAndServe(fmt.Sprintf(":%s", ServerPort), nil); err != nil {
		fmt.Printf("failed to start server on port :%s, %v\n", ServerPort, err)
	}

}

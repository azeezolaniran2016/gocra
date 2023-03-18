package main

import (
	"net/http"
	"os"
)

func main() {
	stDir := os.Getenv("STATIC_DIR")
	http.Handle("/", http.FileServer(http.Dir(stDir)))
	http.Handle("/api", http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(`{"message": "Hello World"}`))
	}))

	http.ListenAndServe(":80", nil)
}

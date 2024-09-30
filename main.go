package main

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/go-vgo/robotgo"
)

// moveCursor moves the cursor to a random position on the screen
func moveCursor(screenWidth, screenHeight int) {
	x := rand.Intn(screenWidth - 250)
	y := rand.Intn(screenHeight - 250)
	fmt.Printf("Moving cursor to [%d, %d]\n", x, y)
	robotgo.MoveSmooth(x, y, 1.0, 10.0)
}

// getRandomWaitTime generates a random wait time between 5 and 15 seconds
func getRandomWaitTime() float64 {
	return rand.Float64()*10 + 5
}

func main() {
	// Seed the random number generator
	rand.Seed(time.Now().UnixNano())

	// Get screen dimensions
	screenWidth, screenHeight := robotgo.GetScreenSize()
	fmt.Printf("Screen Width: %d - Screen Height: %d\n", screenWidth, screenHeight)

	// Infinite loop to randomly move the cursor
	for {
		// Move the cursor
		moveCursor(screenWidth, screenHeight)

		// Get random wait time and sleep
		waitTime := getRandomWaitTime()
		fmt.Printf("Waiting for %.2f seconds...\n", waitTime)
		time.Sleep(time.Duration(waitTime) * time.Second)
	}
}

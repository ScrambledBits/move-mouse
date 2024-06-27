package main

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/go-vgo/robotgo"
)

func main() {
	screenWidth, screenHeight := robotgo.GetScreenSize()

	for {
		fmt.Printf("Screen Width: %d - Screen Height: %d\n", screenWidth, screenHeight)
		waitTime := rand.Float64()*10 + 5
		x := rand.Intn(screenWidth - 250)
		y := rand.Intn(screenHeight - 250)
		fmt.Printf("Moving cursor to [%d, %d]\n", x, y)
		robotgo.MoveSmooth(x, y, 1.0, 10.0)
		fmt.Printf("Waiting for %.2f seconds...\n", waitTime)
		time.Sleep(time.Duration(waitTime) * time.Second)
	}
}

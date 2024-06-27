#!/bin/bash

set -x

echo "Creating bin directories"
mkdir -p bin/{linux,windows,mac}

# Build for Linux
GOOS=linux GOARCH=amd64 go build -o bin/linux/move_mouse_linux main.go

# Build for Windows
GOOS=windows GOARCH=amd64 go build -o bin/windows/move_mouse_windows.exe main.go

# Build for MacOS
GOOS=darwin GOARCH=amd64 go build -o bin/mac/move_mouse_macos main.go

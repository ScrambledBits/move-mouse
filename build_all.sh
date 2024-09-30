#!/bin/bash

# Set the output directory for the compiled binaries
OUTPUT_DIR="./build"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Array of OS-ARCH combinations to build for
platforms=(
  "darwin:arm64"   # macOS for ARM (Apple Silicon/M1/M3)
  "darwin:amd64"   # macOS for x86_64 (will use Rosetta)
  "linux:amd64"    # Linux for x86_64
  "windows:amd64"  # Windows for x86_64
)

# Loop over each platform and build
for platform in "${platforms[@]}"
do
  # Extract OS and ARCH from platform string
  IFS=":" read -r GOOS GOARCH <<< "$platform"

  # Set the output filename
  OUTPUT_NAME="$OUTPUT_DIR/${GOOS}_${GOARCH}/move-cursor"
  
  # For Windows, append ".exe" to the output file name
  if [ "$GOOS" = "windows" ]; then
    OUTPUT_NAME="$OUTPUT_NAME.exe"
  fi

  # Create a platform-specific directory
  mkdir -p "$(dirname "$OUTPUT_NAME")"

  # Check if we are building for macOS amd64 (x86_64)
  if [ "$GOOS" = "darwin" ] && [ "$GOARCH" = "amd64" ]; then
    echo "Building for $GOOS/$GOARCH using Rosetta..."
    # Use Rosetta to build for amd64
    arch -x86_64 go build -o "$OUTPUT_NAME" .
  else
    echo "Building for $GOOS/$GOARCH..."
    # Normal build process
    env GOOS="$GOOS" GOARCH="$GOARCH" go build -o "$OUTPUT_NAME" .
  fi

  # Check if the build was successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to build for $GOOS/$GOARCH."
    exit 1
  fi

  echo "Build successful: $OUTPUT_NAME"
done

echo "All builds completed successfully!"
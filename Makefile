make: install build

install:
	echo "Installing required packages"
	npm ci
	
build:
	echo "Building static site"
	doppler run -- npx @11ty/eleventy

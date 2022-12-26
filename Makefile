make: install build

make-ci: install build-ci

install:
	echo "Installing required packages"
	npm ci
	
build:
	echo "Building static site"
	doppler run -- npx @11ty/eleventy

build-ci:
	echo "CI: Building static site"
	./doppler run -- npx @11ty/eleventy

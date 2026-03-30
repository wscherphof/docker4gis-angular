#!/bin/bash

angular_json=$(find . -name angular.json | head -n 1)

if [ -z "$angular_json" ]; then
	echo "No angular.json file found in this directory." >&2
	echo "Create an Angular app first, then run the build again." >&2
	exit 1
fi

SRC=$(dirname "$angular_json")

docker image build \
	--build-arg DOCKER_USER="$DOCKER_USER" \
	--build-arg SRC="$SRC" \
	-t "$IMAGE" .

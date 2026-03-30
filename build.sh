#!/bin/bash

angular_json=$(find . -name angular.json | head -n 1)

# Base component builds have no Angular app yet; extending app builds do.
if [ -z "$angular_json" ] && ! [ "${DOCKER_USER:-}" = "docker4gis" ]; then
	echo "No angular.json file found in this directory." >&2
	echo "Create an Angular project first (\`ng new app\`), then run the build again." >&2
	exit 1
fi

SRC=$(dirname "$angular_json")

docker image build \
	--build-arg DOCKER_USER="$DOCKER_USER" \
	--build-arg SRC="$SRC" \
	-t "$IMAGE" .

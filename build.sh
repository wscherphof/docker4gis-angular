#!/bin/bash

angular_json=$(find . -name angular.json | head -n 1)

# If we're building not the base component, but an extension image, and there's
# no angular.json, then we create a new Angular project.
if [ -z "$angular_json" ] && ! [ "${DOCKER_USER:-}" = "docker4gis" ]; then
	which ng || npm install -g @angular/cli &&
		ng new "$DOCKER_USER-app" --skip-git true || exit
fi

SRC=$(dirname "$angular_json")

docker image build \
	--build-arg DOCKER_USER="$DOCKER_USER" \
	--build-arg SRC="$SRC" \
	-t "$IMAGE" .

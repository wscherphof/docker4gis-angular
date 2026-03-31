#!/bin/bash

function src() {
	angular_json=$(find . -name angular.json | head -n 1)
	SRC=$(dirname "$angular_json")
	[ -n "$angular_json" ]
}

# If we're building not the base component, but an extension image, and there's
# no angular.json, then we create a new Angular project.
if ! [ "${DOCKER_USER:?}" = "docker4gis" ] && ! src; then
	which ng || npm install -g @angular/cli &&
		ng new "$DOCKER_USER-app" --skip-git true &&
		src || exit
fi

docker image build \
	--build-arg DOCKER_USER="$DOCKER_USER" \
	--build-arg SRC="$SRC" \
	-t "$IMAGE" .

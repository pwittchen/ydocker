#!/usr/bin/env bash
set -e

DOCKER_IMAGE_NAME=sap-hybris-commerce-suite
HOST_PORT=9002
CONTAINER_PORT=9002

function showHelp() {
  echo "
        ydocker.sh is a shell script responsible
        for building and running SAP Hybris Commerce Suite
        in Docker container

        Usage:
          -b    building Docker container
          -r    running Hyris Server in Docker container
          -c    running Docker container with CLI
          -d    deleting Docker container
          -h    showing help
        "
}

function buildDockerImage() {
  echo -n "SAP username (e-mail): "
  read username
  echo -n "SAP password: "
  read -s password

  sudo docker build --build-arg SAP_USERNAME="$username" \
  --build-arg SAP_PASSWORD="$password" \
  --build-arg COMMERCE_SUITE_VERSION=6.1.0.0.12816 \
  --build-arg RECIPE=b2c_acc \
  -t "$DOCKER_IMAGE_NAME" .
}

function runDockerImageServer() {
  sudo docker run -p 127.0.0.1:"$HOST_PORT":"$CONTAINER_PORT" -t "$DOCKER_IMAGE_NAME"
}

function runDockerImageCli() {
  sudo docker run -i -t "$DOCKER_IMAGE_NAME" /bin/bash
}

function deleteDockerImage() {
  sudo docker rmi -f "$DOCKER_IMAGE_NAME"
}

OPTIND=1 # Reset in case getopts has been used previously in the shell.

while getopts "hbrcd" opt; do
    case "$opt" in
    h)
        showHelp
        exit 0
        ;;
    b)  buildDockerImage
        ;;
    r)  runDockerImageServer
        ;;
    c)  runDockerImageCli
        ;;
    d)  deleteDockerImage
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

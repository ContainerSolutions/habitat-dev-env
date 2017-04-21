#!/bin/sh

docker run --rm --name=habitat --tty --interactive --volume=$(pwd):/mnt \
    --cap-add=SYS_ADMIN --user=$(id -u):$(id -g) habitat sh

#!/bin/sh

docker build -t habitat --build-arg uid=$(id -u) .

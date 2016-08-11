#!/bin/bash


mvn clean package

docker build -t maayanlab/x2k:latest .
docker push maayanlab/x2k:latest

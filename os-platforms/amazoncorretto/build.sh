#!/bin/env bash
docker build \
  --file=Dockerfile \
  --tag=jetty-sh:os-amazoncorretto .


#!/bin/bash

docker run --rm -it -e GITHUB_TOKEN -e SNYK_TOKEN -v "${PWD}":/runtime ghcr.io/snyk-playground/snyk-sync:latest --sync targets --save
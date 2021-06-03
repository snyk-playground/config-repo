#!/bin/bash

# get you a shell in the container, to replicate a build environment
# with our env's we need

docker run -it -e GITHUB_TOKEN -e SNYK_TOKEN -e CI=1 --entrypoint '/bin/bash' -v $(pwd):/app mrzarquon/snyk-api-import:v0.0.1
#!/bin/bash

SCRIPT=$(realpath "${0}")
SCRIPTPATH=$(dirname "$SCRIPT")

OLD_PATH=$PATH
PATH="${SCRIPTPATH}/bin":$PATH

export SNYK_IMPORT_PATH="${SNYK_LOG_PATH}/github-import-targets.json"

export SNYK_TOKEN=$SNYK_TOKEN

echo "Snyk Secret is: ${SNYK_SECRET}"

snyk-api-import --file=import-targets.json

#snyk-api-import list:imported --integrationType=github-enterprise --orgId=39ddc762-b1b9-41ce-ab42-defbe4575bd6

PATH=$OLD_PATH
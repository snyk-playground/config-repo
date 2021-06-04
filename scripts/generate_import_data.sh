#!/bin/bash

SCRIPT=$(realpath "${0}")
SCRIPTPATH=$(dirname "$SCRIPT")

OLD_PATH=$PATH
PATH="${SCRIPTPATH}/bin":$PATH

temp_json_file=$(mktemp)

snyk-api-import import:data --orgsData=org-data.json --source=github --integrationType=github-enterprise

jq -f org-filter.jq "${SNYK_LOG_PATH}/github-import-targets.json" > "$temp_json_file"
mv "$temp_json_file" "${SNYK_LOG_PATH}/github-import-targets.json"

PATH=$OLD_PATH
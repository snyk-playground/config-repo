#!/bin/bash

CWD=$(pwd)
# We want to safely delete only this scripts temp files, so we name them
TMP_DIR=$(mktemp -d -t install_snyk_tools.XXXXXXXXXX)

SCRIPT=$(realpath "${0}")
SCRIPTPATH=$(dirname "$SCRIPT")

cd "${TMP_DIR}" || exit

curl -s https://api.github.com/repos/snyk/snyk/releases/latest \
    | jq -c '.assets[] | select (.browser_download_url | contains ("linux")) | .browser_download_url' \
    | xargs -I snyk_url curl -s -L -O snyk_url && sha256sum -c snyk-linux.sha256 && \
    mv snyk-linux "${SCRIPTPATH}"/bin/snyk && chmod +x "${SCRIPTPATH}"/bin/snyk

curl -s https://api.github.com/repos/snyk-tech-services/snyk-api-import/releases/latest \
    | jq -c '.assets[] | select (.browser_download_url | contains ("linux")) | .browser_download_url' \
    | xargs -I snyk_url curl -s -L -O snyk_url && sha256sum -c snyk-api-import-linux.sha256 && \
    mv snyk-api-import-linux "${SCRIPTPATH}"/bin/snyk-api-import && chmod +x "${SCRIPTPATH}"/bin/snyk-api-import

cd "${CWD}" || exit

# Since our tempdir always starts with install_snyk_tools
rm -r /tmp/install_snyk_tools.*
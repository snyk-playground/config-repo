#!/bin/bash

CWD=$(pwd)
# We want to safely delete only this scripts temp files, so we name them
TMP_DIR=$(mktemp -d -t install_snyk_tools.XXXXXXXXXX)

cd "${TMP_DIR}" || exit

curl -s https://api.github.com/repos/snyk/snyk/releases/latest \
    | jq -c '.assets[] | select (.browser_download_url | contains ("linux")) | .browser_download_url' \
    | xargs -I snyk_url curl -s -L -O snyk_url && sha256sum -c snyk-linux.sha256 && \
    mv snyk-linux /usr/local/bin/snyk && chmod +x /usr/local/bin/snyk

curl -s https://api.github.com/repos/snyk-tech-services/snyk-api-import/releases/latest \
    | jq -c '.assets[] | select (.browser_download_url | contains ("linux")) | .browser_download_url' \
    | xargs -I snyk_url curl -s -L -O snyk_url && sha256sum -c snyk-api-import-linux.sha256 && \
    mv snyk-api-import-linux "${CWD}"/.bin/snyk-api-import && chmod +x "${CWD}"/.bin/snyk-api-import

cd "${CWD}" || exit

# Since our tempdir always starts with install_snyk_tools
rm -r /tmp/install_snyk_tools.*
#!/bin/bash

REPO=$1
if [[ -z "${REPO// }" ]]; then
    echo "Please provide repo name (fmt = owner/repo)."
else
    curl -s https://api.github.com/repos/${REPO}/releases/latest | grep "browser_download_url" | grep "linux64\"" | cut -d '"' -f 4 | wget -i -
fi

#!/bin/bash
ROOT_DIR="/Significant-Gravitas"

CURRENT_DIR=$(pwd)
git config --global --add safe.directory ${ROOT_DIR}
cd "${ROOT_DIR}"
#git pull
pip install --upgrade -r requirements.txt

REPOS="Auto-GPT Auto-GPT-SystemInfo Auto-GPT-Plugins Auto-GPT-Plugins-YouTube"
PLUGINS="Auto-GPT-SystemInfo Auto-GPT-Plugins Auto-GPT-Plugins-YouTube"

for repo in ${REPOS}; do
    git config --global --add safe.directory ${ROOT_DIR}/${repo}
    cd "${ROOT_DIR}/${REPO}"
    git pull
    if [ -f requirements.txt ]; then
        pip install --upgrade -r requirements.txt
        cd ..
    fi
done

for plugin in ${PLUGINS}; do
    cd "${ROOT_DIR}/${plugin}"
    zip -ru "${ROOT_DIR}/Auto-GPT/plugins/${plugin}.zip" .
done

cd "${CURRENT_DIR}"

echo "Done!"
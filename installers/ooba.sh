#!/bin/bash

  git clone https://github.com/oobabooga/text-generation-webui.git "${INSTALL_DIR}"
  cd "${INSTALL_DIR}"
  python -m venv venv
  source venv/bin/activate
  pip install -r requirements.txt
  python server.py ${PARAMS}
  deactivate
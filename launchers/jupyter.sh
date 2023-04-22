#!/bin/bash

# If unset, set the environment variables with default values
INSTALL_DIR="${INSTALL_DIR:-${HOME}/jupyter}"
LISTEN_PORT="${LISTEN_PORT:-17256}"
PARAMS="${PARAMS:-notebook --ip=0.0.0.0}" # --port 17256}"

# run the application if it is installed
if [ -d "${INSTALL_DIR}" ]; then
  cd "${INSTALL_DIR}"
  if [ -d "venv" ]; then
    # activate the virtual environment
    source venv/bin/activate
    # install the requirements
    pip install --upgrade pip
    pip install --upgrade jupyter
    # run the application
    exec jupyter ${PARAMS} --port ${LISTEN_PORT}
    deactivate
  else
    echo "ERROR: Jupyter python environment not found in ${INSTALL_DIR}."
    echo "       Please run installers/jupyter.sh to install the application."
    exit 1
  fi
else
  echo "WARNING: ${INSTALL_DIR} not found"
  echo "       Please run installers/jupyter.sh to install the application."
  exit 1
fi

# usage: jupyter [-h] [--version] [--config-dir] [--data-dir] [--runtime-dir] [--paths] [--json] [--debug] [subcommand]
# 
# Jupyter: Interactive Computing
# 
# positional arguments:
#   subcommand     the subcommand to launch
# 
# options:
#   -h, --help     show this help message and exit
#   --version      show the versions of core jupyter packages and exit
#   --config-dir   show Jupyter config dir
#   --data-dir     show Jupyter data dir
#   --runtime-dir  show Jupyter runtime dir
#   --paths        show all Jupyter paths. Add --json for machine-readable format.
#   --json         output paths as machine-readable json
#   --debug        output debug information about paths
# 
# Available subcommands: bundlerextension console dejavu events execute kernel kernelspec migrate nbclassic nbconvert
# nbextension notebook qtconsole run server serverextension troubleshoot trust
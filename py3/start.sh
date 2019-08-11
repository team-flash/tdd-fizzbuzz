#!/bin/bash

set -ex

abspath() {
	echo $(python -c "import os; print os.path.abspath('$1')")
}

MY_PATH=$(abspath $(dirname "$0"))
mkdir -p ${MY_PATH}/tmp
cp -f ${MY_PATH}/vscode/launch.json ${MY_PATH}/tmp/launch.json
docker pull teamflash/py3dev
docker run -it --rm -p 6901:6901 \
    -e RUNNER_UID=$(id -u) \
    -e RUNNER_GID=$(id -g) \
    -e VNC_RESOLUTION=1440x860 \
    -v ${MY_PATH}/src:/headless/py3 \
    -v ${MY_PATH}/tmp/launch.json:/headless/py3/.vscode/launch.json \
    teamflash/py3dev

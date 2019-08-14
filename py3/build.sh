#!/bin/bash

set -ex

abspath() {
	echo $(python -c "import os; print os.path.abspath('$1')")
}

MY_PATH=$(abspath $(dirname "$0"))
docker build -t teamflash/py3dev:1.0 ${MY_PATH}

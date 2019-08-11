#!/bin/bash

set -e
if [[ ! -z ${RUNNER_UID} ]] && [[ ! -z ${RUNNER_GID} ]]; then
# Set user teamflash uid and gid to match to the run user
usermod -u ${RUNNER_UID} teamflash
if which addgroup > /dev/null 2>&1; then
    addgroup --gid ${RUNNER_GID} runner || :
else
    (which groupadd > /dev/null 2>&1 && groupadd -g ${RUNNER_GID} runner) || :
fi
usermod -g ${RUNNER_GID} teamflash
chown teamflash:teamflash -R /headless
fi

# add `--skip` to startup args, to skip the VNC startup procedure
if [[ $1 =~ -s|--skip ]]; then
    echo -e "\n\n------------------ SKIP VNC STARTUP -----------------"
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '${@:2}'"
    exec "${@:2}"
fi
if [[ $1 =~ -d|--debug ]]; then
    echo -e "\n\n------------------ DEBUG VNC STARTUP -----------------"
    export DEBUG=true
fi

su teamflash -c "HOME=$HOME /dockerstartup/startup.sh $@"

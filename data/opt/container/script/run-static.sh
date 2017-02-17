#!/bin/bash

. /opt/container/script/unit-utils.sh

# Check required environment variables and fix the NGINX unit configuration.

checkCommonRequiredVariables

if [ ! -d /opt/container/www-static ]
then
     logWarning "volume /opt/container/www-static is not mounted; no static content is available"

     mkdir -p /opt/container/www-static
fi

notifyUnitLaunched

content_dir=/opt/container/shared/var/www/static-`hostname`
unit_conf=`copyUnitConf nginx-unit-static`

mkdir -p /opt/container/shared/var/www
cp -R /opt/container/www-static ${content_dir}

fileSubstitute ${unit_conf} content_dir ${content_dir}

notifyUnitStarted

logUrlPrefix "static content located in ${content_dir}"

# Not technically needed, but when using Docker Compose it looks nicer to not have this container exit.

tail -f /dev/null &

pid=$!

trap "kill -TERM ${pid}" INT KILL TERM

wait ${pid}

exit 0

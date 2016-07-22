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

content_dir=/var/www/static-`randomInt`
filename=`copyUnitConf nginx-unit-static`

ln -s /opt/container/www-static ${content_dir}

fileSubstitute ${filename} content_dir ${content_dir}

notifyUnitStarted

# Not technically needed, but when using Docker Compose it looks nicer to not have this container exit.

tail -f /dev/null

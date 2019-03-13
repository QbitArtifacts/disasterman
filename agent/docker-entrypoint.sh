#!/usr/bin/env bash

if [[ "$SERVER" == "" ]];then
    echo "[WARN] ENV SERVER not specified, using 'server' as default" >&2
    export SERVER=server
fi

envsubst < /backups.cron > /etc/cron.d/disasterman

cron -f


#!/usr/bin/env bash

if [[ "$SERVER" == "" ]];then
    echo "[WARN] ENV SERVER not specified, using 'server' as default" >&2
    export SERVER=server
fi
if [[ "$CRON_SCHEDULE" == "" ]];then
    echo "[WARN] ENV CRON_SCHEDULE not specified, using '*/5 * * * *' as default" >&2
    export CRON_SCHEDULE="*/5 * * * *"
fi

# Do the first copy now
/copy_all_volumes_except_untagged.sh

# Install cron for every minute backup
envsubst < /backups.cron > /etc/cron.d/disasterman

cron -f


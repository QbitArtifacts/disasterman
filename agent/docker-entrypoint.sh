#!/usr/bin/env bash

if [[ "$SERVER" == "" ]];then
    echo "[WARN] ENV SERVER not specified, using 'server' as default" >&2
    export SERVER=server
fi

#Do the first copy now
/usr/bin/rsync -e "ssh -o StrictHostKeyChecking=no" -a --delete /volumes $SERVER:/backups/latest/`hostname`

envsubst < /backups.cron > /etc/cron.d/disasterman

cron -f


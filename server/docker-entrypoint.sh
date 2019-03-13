#!/usr/bin/env bash

if ! test -d /backups/latest;then
    mkdir -p /backups/latest
fi

/usr/sbin/cron -f &
/usr/sbin/sshd -D &

wait


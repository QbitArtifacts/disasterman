#!/usr/bin/env bash


PERIODS="latest hourly daily weekly monthly"

for period in $PERIODS;do
    if ! test -d /backups/$period;then
        mkdir -p /backups/$period
    fi
done

/usr/sbin/cron -f &
/usr/sbin/sshd -D &

wait


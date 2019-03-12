#!/usr/bin/env bash

/usr/sbin/cron -f &
/usr/sbin/sshd -D &

wait


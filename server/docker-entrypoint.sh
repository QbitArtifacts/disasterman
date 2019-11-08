#!/usr/bin/env bash

force_exit(){
  echo "CTRL+C detected, stopping the server..."
  exit 0
}

trap force_exit SIGINT

echo -n "Setting up the environment... "
if ! test -d /etc/rdiffweb;then
  mkdir -p /etc/rdiffweb
fi

envsubst < rdw.conf.dist > /etc/rdiffweb/rdw.conf
echo "OK"

echo -n "Starting SSH server... "
/usr/sbin/sshd -D &
echo "OK"

echo -n "Starting GUI server..."
rdiffweb > /dev/null 2>&1 &
echo "OK"

echo -n "Waiting for the server to be online... "
sleep 2
echo "OK"

echo -n "Setting up users and repositories... "
PASSWORD=$(echo -n "$ADMIN_PASSWORD" | sha1sum | cut -f1 -d" ")
cat <<SQL | sqlite3 /etc/rdiffweb/rdw.db
update users set Password='$PASSWORD', UserRoot='/backups';
SQL
echo "OK"

echo "ALL DONE"

wait

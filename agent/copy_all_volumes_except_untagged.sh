#!/usr/bin/env bash

EXCLUDEFILE=/tmp/exclude-$RANDOM$RANDOM$RANDOM.txt
echo "Using exclude file: $EXCLUDEFILE"

echo -n > $EXCLUDEFILE

ls /volumes | grep -E "^[a-f0-9]{64}$" | while read volume;do
    echo "/volumes/$volume" >> $EXCLUDEFILE
done

/usr/bin/rsync -e "ssh -o StrictHostKeyChecking=no" -az --delete --exclude-from=$EXCLUDEFILE /volumes $SERVER:/backups/latest/`hostname`


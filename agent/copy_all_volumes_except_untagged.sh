#!/usr/bin/env bash

EXCLUDEFILE=/tmp/exclude-$RANDOM$RANDOM$RANDOM.txt
echo "Using exclude file: $EXCLUDEFILE"

echo -n > $EXCLUDEFILE

ls /volumes | grep -E "^[a-f0-9]{64}$" | while read volume;do
    echo "/volumes/$volume" >> $EXCLUDEFILE
done
ssh -o StrictHostKeyChecking=no $SERVER "ls" > /dev/null

/usr/bin/rdiff-backup --exclude-filelist $EXCLUDEFILE /volumes $SERVER:/backups/`/bin/hostname`


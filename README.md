# DisasterMan
Backup and recovery manager tool for docker swarm powered by `rdiff-backup`.

The system launches an _agent_ container in every node (mode global) and one _server_ container which stores all copies. The system copies all named volumes (WARNING: excludes non-named ones!) from every node using `rdiff-backup`.  The copy process is automatic every minute.

# For Docker Swarm
This project is developed to use with docker swarm mode, it is not tested with other configurations.


# Installation
Modify `stack.yml` according with your neededs using the options section and deploy the stack.
```
git clone https://github.com/QbitArtifacts/disasterman
cd disasterman
# edit stack.yml ...
docker stack deploy -f stack.yml
```

# Options
Options are passed via environment variables (all optional) and [node labels](https://docs.docker.com/engine/swarm/manage-nodes/):
## Node labels
Node labelling is useful for avoid to backup the backup server inside itself, in the example configuration in `stack.yml`, the server is deployed in a node with label `purpose.main = backup` and the nodes in **every other** nodes. 

So the _backup server_ node must be labelled with `purpose.main = backup`.

## Environment VARS
```
# default interval is 1 minute, available X[mhd] for X minutes, hours or days
COPY_INTERVAL: 5m 

# by default doesn't make daily, weekly or monthly external copies
DAILY_EXTERNAL_BACKUP: ssh://backups@daily.domain.net:/backups
WEEKLY_EXTERNAL_BACKUP: ssh://backups@weekly.domain.net:/backups
MONTHLY_EXTERNAL_BACKUP: ftp://backups:securepass@monthly.domain.net:/backups
```

# Backup process
The backup process is fully automatic.

Every minute each _agent_ container makes an incremental copy of its node `/var/lib/docker/volumes` against the _server_ container. At the first execution, the _agent_ makes a full backup against server before starting the scheduler, it may take some time depending of the data to back up.

If it's defined any of `DAILY_EXTERNAL_BACKUP`, `WEEKLY_EXTERNAL_BACKUP` or `MONTHLY_EXTERNAL_BACKUP` ENV variables, the system will make an full copy to the specified locations using `sftp`, `scp` or `ftp` and compressed in `tar.gz` format.

# Restore process
Restore process from the _server_ node it's easy from the node desired to restore:
```
# example of restore of all volumes in a node from 10 days ago.
rdiff-backup --restore-as-of 10D $SERVER::/backups/$(/bin/hostname)/volumes /volumes
```

Restoration from external locations is not implemented yet :(.

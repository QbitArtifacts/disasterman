# DisasterMan
Backup and recovery manager tool for docker swarm powered by 
[rdiff-backup](https://www.nongnu.org/rdiff-backup/) to do the copies and a nice
UI using [rdiffweb](https://github.com/ikus060/rdiffweb) to see and restore the backups.

The system launches an _agent_ container in every node (mode global) and one _server_
container which stores all copies. The system copies all named volumes (WARNING: it 
excludes non-named ones!) from every node using `rdiff-backup`.  The copy process
is automatic every 5 minutes.

The _server_ container also has a nice UI available in port 8080. For more info about
the UI check the project [rdiffweb](https://github.com/ikus060/rdiffweb).

# For Docker Swarm
This project is developed to use with docker swarm mode, it is not tested with other
orchestators.

# NOT for `docker-compose`
Do not execute this stack with `docker-compose`, so it is designed to copy all volumes
from each node except the server (where agent is deployed) to the node where the server
is deployed.

Because `docker-compose` runs all containers in the same machine (same node) and this tool
takes all volumes in `/var/lib/docker/volumes` for the backup, the tool will back up the 
backups volume too, so it will fill the disk very quickly with backups of backups recursively.

# Installation
Modify `stack.yml` according with your neededs using the options section and deploy the stack.
```
git clone https://github.com/QbitArtifacts/disasterman
cd disasterman
# edit stack.yml ...
docker stack deploy -f stack.yml
```

# Options
Options are passed via environment variables and [node labels](https://docs.docker.com/engine/swarm/manage-nodes/):
## Node labels
Node labelling is useful for avoid to backup the backup server inside itself,
in the example configuration in `stack.yml`, the server is deployed in a node with
label `backups == server` and the agents in **every other** nodes using `backups != server`
constraint. 

So the _backup server_ node must be labelled with `backups: server`.

## Environment VARS
### Agent
* `CRON_SCHEDULE` cron-like schedule for node backups,
default is `*/5 * * * *` (every 5 minutes).
### Server
* `HEADER_NAME` header name shown at top left of the UI.
* `ADMIN_PASSWORD` password for user `admin` to login.
* `SMTP_SERVER` mail server used for notifications.
* `SMTP_ENCRYPTION` type of authentication for the server.
* `SMTP_USERNAME` username for the mailing user.
* `SMTP_PASSWORD` password for the mailing user.

# Backup process
The backup process is fully automatic.

Every minute every _agent_ container makes an incremental copy of its node's
`/var/lib/docker/volumes` against the _server_ container. At the first execution,
the _agent_ makes a full backup against server before starting the scheduler,
it may take some time depending of the data to back up.

# Restore process
## Web Interface
To see and restore files with the Web interface, you must go to `<server-ip>:8080`, do
login with username `admin` and password the provided one with `ADMIN_PASSWORD` env var
and download the compressed copies from the server.

## Console
Restore process from the _server_ node it's easy from the node desired to restore:
```
# example of restore of all volumes in a node from 10 days ago.
rdiff-backup --restore-as-of 10D $SERVER::/backups/$(/bin/hostname)/volumes /volumes
```

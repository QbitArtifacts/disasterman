from debian
run apt update && apt install -y openssh-server rsync cron
run mkdir /run/sshd

copy docker-entrypoint.sh /
run chmod +x docker-entrypoint.sh

copy agent.pub /root/.ssh/authorized_keys
copy backups.cron /etc/cron.d/disasterman

cmd ["/docker-entrypoint.sh"]


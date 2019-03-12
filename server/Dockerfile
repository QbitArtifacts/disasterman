from debian
run apt update && apt install -y openssh-server rsync cron
run mkdir /run/sshd

copy docker-entrypoint /
run chmod +x docker-entrypoint

copy agent.pub /root/.ssh/authorized_keys
copy backups.cron /etc/cron.d/disasterman

cmd ["/docker-entrypoint.sh"]


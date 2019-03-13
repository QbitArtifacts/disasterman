from debian
run apt update && apt install -y rsync cron openssh-client settext-base

copy backups.cron /
copy docker-entrypoint.sh /
run chmod +x docker-entrypoint.sh

run mkdir -p /root/.ssh
copy agent.key /root/.ssh/id_rsa

cmd ["/docker-entrypoint.sh"]


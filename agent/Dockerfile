from debian
run apt update && apt install -y rdiff-backup openssh-client cron gettext-base

copy agent/backups.cron /
copy agent/docker-entrypoint.sh /
run chmod +x /docker-entrypoint.sh

copy agent/copy_all_volumes_except_untagged.sh /
run chmod +x /copy_all_volumes_except_untagged.sh

run mkdir -p /root/.ssh && chmod 700 /root/.ssh
copy agent/agent.key /root/.ssh/id_rsa
run chmod 600 /root/.ssh/id_rsa

cmd ["/docker-entrypoint.sh"]


from debian
run apt update && apt install -y gettext-base wget curl sqlite3 rdiff-backup openssh-server python3-pip python3-ldap
run pip3 install rdiffweb==1.1.0

run mkdir /run/sshd

copy server/agent.pub /root/.ssh/authorized_keys
copy server/rdw.conf.dist /

copy server/docker-entrypoint.sh /
run chmod +x /docker-entrypoint.sh

cmd ["/docker-entrypoint.sh"]


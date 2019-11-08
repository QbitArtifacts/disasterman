from debian
run apt update && apt install -y gettext-base wget sqlite3 rdiff-backup openssh-server python3-pip python3-ldap
run pip3 install rdiffweb==1.1.0

run mkdir /run/sshd

copy agent.pub /root/.ssh/authorized_keys
copy rdw.conf.dist /

copy docker-entrypoint.sh /
run chmod +x /docker-entrypoint.sh

cmd ["/docker-entrypoint.sh"]


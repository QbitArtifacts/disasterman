from debian
run apt update && apt install -y openssh-server rsync
run mkdir /run/sshd
copy agents.pub /root/.ssh/authorized_keys


cmd ["/usr/sbin/sshd", "-D"]


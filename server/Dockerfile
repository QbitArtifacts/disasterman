from debian
run apt update && apt install -y rdiff-backup openssh-server 
run mkdir /run/sshd

copy agent.pub /root/.ssh/authorized_keys

cmd ["/usr/sbin/sshd", "-D"]


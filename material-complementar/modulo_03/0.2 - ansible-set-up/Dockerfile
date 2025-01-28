FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y openssh-server python3 grep rsyslog && \
    mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

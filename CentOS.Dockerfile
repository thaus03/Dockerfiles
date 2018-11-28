FROM centos:latest

RUN yum update -y && yum install -y net-tools openssh-server openssh-clients
RUN mkdir /var/run/sshd
RUN echo 'root:Manager1' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# CRIA AS CHAVES
RUN ssh-keygen -q -N '' -f /etc/ssh/ssh_host_rsa_key -t rsa && ssh-keygen -q -N '' -f /etc/ssh/ssh_host_ecdsa_key -t ecdsa && ssh-keygen -q -N '' -f /etc/ssh/ssh_host_ed25519_key -t ed25519

# HABILITA PORTA SSH E MONGODB
EXPOSE 22 27017

# EXECUTA O BASH
ENTRYPOINT /usr/sbin/sshd && /bin/bash
#CMD /bin/bash


FROM ubuntu:latest

# ATUALIAZA O REPOSITÓRIO E INSTALA PROGRAMAS PADRÕES (vi, ipconfig, ping e ssh)
RUN apt-get update && apt-get install -y software-properties-common apt-utils net-tools iputils-ping vim openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:Manager1' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

# ADICIONA O REPOSITÓRIO ANSIBLE E INSTALA O SOFTWARE
RUN apt-add-repository --yes --update ppa:ansible/ansible
RUN apt-get update && apt-get -y upgrade && apt-get -y install ansible
RUN mkdir -p /root/ansible

# Habilita a interatividade
#CMD ["/usr/sbin/sshd", "-D"]
CMD /bin/bash


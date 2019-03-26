FROM ubuntu:latest

# ATUALIAZA O REPOSITÓRIO E INSTALA PROGRAMAS PADRÕES (vi, ipconfig, ping e ssh)
RUN apt-get update && apt-get install -y software-properties-common apt-utils net-tools iputils-ping vim openssh-server python
RUN mkdir /var/run/sshd
RUN echo 'root:Manager1' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 27/Port 27/' /etc/ssh/sshd_config

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 27

# Habilita a interatividade
# EXECUTA O SERVIDOR SSH (/usr/sbin/sshd)

CMD /bin/bash



# FROM ubuntu:latest

# # ATUALIAZA O REPOSITÓRIO E INSTALA O ANSIBLE E O VI COM SUAS DEPENDENCIAS
# RUN apt-get update && apt-get -y install software-properties-common
# RUN apt-get update && apt-get -y upgrade && apt-get -y install \
#     apt-utils ansible vim
# RUN mkdir -p /root/ansible

# # Habilita a interatividade 
# CMD /bin/bash
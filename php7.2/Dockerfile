FROM ubuntu:latest


# Install apache, PHP, and supplimentary programs. openssh-server, curl, and lynx-cur are for debugging the container.
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    apt-utils apache2 php7.2 php7.2-mysql libapache2-mod-php7.2 curl lynx* vim net-tools

# Enable apache mods.
RUN a2enmod php7.2
RUN a2enmod rewrite

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.2/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.2/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose apache.
EXPOSE 80

# Create Volume

# Copy this repo into place.
#ADD www /var/www/site

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default start up apache in the foreground, override with /bin/bash for interative.
CMD /bin/bash
#CMD /usr/sbin/apache2ctl -D FOREGROUND


###############
### PROBLEM ###
###############


# AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message

################
### SOLUTION ###
################

# This is just a friendly warning and not really a problem (as in that something does not work). If you insert a

# ServerName localhost   

# in either httpd.conf or apache2.conf in /etc/apache2 and restart apache the notice will disappear. If you have a name inside /etc/hostname you can also use that name instead of localhost. And it uses 127.0.1.1 if it is inside your /etc/hosts:

# 127.0.0.1 localhost
# 127.0.1.1 myhostname
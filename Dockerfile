FROM debian:stable
MAINTAINER Glenn Y. Rolland <glenux@glenux.net>

# Install packages for building ruby
RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -q -y apache2 libapache2-mod-php5
RUN apt-get install -q -y make libmysqlclient-dev mysql-client


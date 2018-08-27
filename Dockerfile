FROM ubuntu:latest

MAINTAINER jakezp@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Update and install packages
RUN apt-get update && apt-get upgrade -yq && apt-get install supervisor nginx openssl ca-certificates -yq

# Add config files
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD nginx.conf /etc/nginx/conf.d/reverseproxy.conf
ADD run.sh /run.sh
RUN rm /etc/init.d/nginx

# Create directories
RUN mkdir /etc/ssl/certs/nginx

# Set permissions
RUN chmod +x /run.sh

# Expose volumes & ports
VOLUME ["/etc/ssl/certs/nginx/"]
EXPOSE 80 443

WORKDIR /
CMD ["/run.sh"]
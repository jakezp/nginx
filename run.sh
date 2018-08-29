#!/bin/bash

# Add config file & configure nginx
if [[ ! -f /etc/nginx/conf.d/reverseproxy.conf ]]; then
  mv /nginx.conf /etc/nginx/conf.d/reverseproxy.conf
  sed -i "s/SERVERNAME/$SERVERNAME/g" /etc/nginx/conf.d/reverseproxy.conf
  sed -i "s/HOSTIP/$HOSTIP/g" /etc/nginx/conf.d/reverseproxy.conf
  sed -i "s/DESTPORT/$DESTPORT/g" /etc/nginx/conf.d/reverseproxy.conf
fi
if [[ ! -f /etc/ssl/certs/nginx/dh2048.pem ]]; then
  openssl dhparam -out /etc/ssl/certs/nginx/dh2048.pem 2048
fi

# Use supervisord to start all processes
supervisord -c /etc/supervisor/conf.d/supervisord.conf

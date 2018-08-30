#!/bin/bash

# Add config file & configure nginx
if [[ ! -f /etc/nginx/conf.d/reverseproxy.conf ]]; then
  echo -e "Setting up nginx"
  mv /nginx.conf /etc/nginx/conf.d/reverseproxy.conf
  sed -i "s/SERVERNAME/$SERVERNAME/g" /etc/nginx/conf.d/reverseproxy.conf
  sed -i "s/HOSTIP/$HOSTIP/g" /etc/nginx/conf.d/reverseproxy.conf
  sed -i "s/DESTPORT/$DESTPORT/g" /etc/nginx/conf.d/reverseproxy.conf
fi

if [[ ! -f /etc/ssl/certs/nginx/dh2048.pem ]]; then
  echo -e "Generating DH cert"
  openssl dhparam -out /etc/ssl/certs/nginx/dh2048.pem 2048
fi

# Create letencrypt directory
mkdir -p /data/letsencrypt

# Use supervisord to start all processes
echo -e "Starting supervisord"
supervisord -c /etc/supervisor/conf.d/supervisord.conf &

# Generate letsencrypt certificates
if [[ ! -d /etc/letsencrypt/live/$SERVERNAME ]]; then
  echo -e "Generating certificates..."
  certbot certonly --webroot --email $EMAIL --agree-tos --no-eff-email --webroot-path=/data/letsencrypt -d $SERVERNAME
  sed -i 's/^## //g' /etc/nginx/conf.d/reverseproxy.conf
  supervisorctl restart nginx
fi

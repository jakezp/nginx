# Simple nginx reverse proxy

Simple nginx reverse proxy to secure app on port 80.

Run with:
```
docker run -d --name='nginx' --net='bridge' \
      -e 'SERVERNAME'='fqdn' \
      -e 'HOSTIP'='host_ip' \
      -e 'DESTPORT'='dest_port' \
      -e 'EMAIL'='your_email' \
      -p '80:80/tcp' -p '443:443/tcp' \
      -v '/tmp/nginx/config':'/etc/nginx/conf.d/' \
      jakezp/nginx
```

Change:
SERVERNAME - FQDN of host / instance / site
HOSTIP - Host IP address
DESTPORT - Port of the destination application / service
EMAIL - Email address (required for letsencrypt certificates)
/tmp/nginx/config - preferred nginx config location on the host

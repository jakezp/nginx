# Simple nginx reverse proxy

Simple nginx reverse proxy to secure app on port 80.

Run with:
```
docker run -d --name='nginx' --net='bridge' \
      -e 'SERVERNAME'='fqdn' \
      -e 'HOSTIP'='host_ip' \
      -e 'DESTPORT'='dest_port' \
      -p '80:80/tcp' -p '443:443/tcp' \
      -v '/tmp/nginx/certs':'/etc/ssl/certs/nginx/' \
      -v '/tmp/nginx/config':'/etc/nginx/conf.d/' \
      jakezp/nginx
```

Change:
SERVERNAME - FQDN of host / instance / site
HOSTIP - Host IP address
DESTPORT - Port of the destination application / service
/tmp/nginx/certs - preferred certificates location on the host
/tmp/nginx/config - preferred nginx config location on the host

Create /tmp/nginx (change to preferred location on host) and copy certs as $SERVERNAME.crt and $SERVERNAME.key (example.com.crt and example.com.key) to this location before runnig creating container.

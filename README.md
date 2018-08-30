# Simple nginx reverse proxy with auto ssl generation

Simple nginx reverse proxy configuration to secure app on port different destination port. Also include auto ssl certificate generation and renewal, using letsencrypt.

Certificate will be generated on initial start and cron configured to renew certificates once a week. If the certificates are not yet within 30 days of expiry, the renewal will not be completed.

Run with:
```
docker run -d --name='nginx' --net='bridge' \
      -e 'SERVERNAME'='fqdn' \
      -e 'HOSTIP'='host_ip' \
      -e 'DESTPORT'='dest_port' \
      -e 'EMAIL'='your_email' \
      -p '80:80/tcp' -p '443:443/tcp' \
      -v '/tmp/nginx/config':'/etc/nginx/conf.d/' \
      -v '/tmp/nginx/sslcerts':'/etc/letsencrypt/' \
      jakezp/nginx
```

Change:
SERVERNAME - FQDN of host / instance / site
HOSTIP - Host IP address
DESTPORT - Port of the destination application / service
EMAIL - Email address (required for letsencrypt certificates)
/tmp/nginx/config - preferred nginx config location on the host
/tmp/nginx/sslcerts - letsencrypt config and cert location

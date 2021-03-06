# Simple nginx reverse proxy with auto ssl generation

Simple nginx reverse proxy configuration to secure app on port different destination port. Also include auto ssl certificate generation and renewal, using letsencrypt.

Certificate will be generated on initial start and cron configured to renew certificates once a week. If the certificates are not yet within 30 days of expiry, the renewal will not be completed.

**NB** Ensure your DNS has been configured correctly. Create an A record for SERVERNAME to point to the public IP address of your host, or else the certificate authorization will fail.

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

Change:<br>
SERVERNAME - FQDN of host / instance / site<br>
HOSTIP - Host IP address<br>
DESTPORT - Port of the destination application / service<br>
EMAIL - Email address (required for letsencrypt certificates)<br>
/tmp/nginx/config - preferred nginx config location on the host<br>
/tmp/nginx/sslcerts - letsencrypt config and cert location

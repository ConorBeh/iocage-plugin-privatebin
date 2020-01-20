#!/bin/sh

# Enable services
sysrc lighttpd_enable=YES
sysrc php_fpm_enable=YES

# Enable SSL with a self signed cert. It is mandatory for Chrome to work with PrivateBin
cd /etc/ssl
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=US/ST=PB/L=pbin/O=pbin/CN=pbin" -keyout privatebin.key -out privatebin.cer 2>/dev/null

# Wait for SSL to finish its thing
sleep 10

# Create a pem file for the web server to use
cat privatebin.key privatebin.cer > privatebin.pem

# Start services
service lighttpd start 2>/dev/null
service php-fpm start 2>/dev/null


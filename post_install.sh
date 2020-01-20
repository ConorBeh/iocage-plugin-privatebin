#!/bin/sh

# Enable services
sysrc lighttpd_enable=YES
sysrc php_fpm_enable=YES

# Enable SSL with a self signed cert. Without SSL enabled, PrivateBin will not function when accessed via Google Chrome
cd /etc/ssl
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=US/ST=PB/L=pbin/O=pbin/CN=pbin" -keyout privatebin.key -out privatebin.cer 2>/dev/null

# Wait for SSL to finish its thing
sleep 10

# Create a pem file for the web server to use
cat privatebin.key privatebin.cer > privatebin.pem

# Start services
service lighttpd start 2>/dev/null
service php-fpm start 2>/dev/null

# Explain SSL cert
echo "PrivateBin requires SSL to function correctly with Google Chrome."
echo "A self-signed certificate was generated and installed for this purpose."
echo "The self-signed certificate can be replaced with a proper version by the user."

# Save the above warnings in PLUGIN_INFO
echo "PrivateBin requires SSL to function correctly with Google Chrome." >> /root/PLUGIN_INFO
echo "A self-signed certificate was generated and installed for this purpose." >> /root/PLUGIN_INFO
echo "The self-signed certificate can be replaced with a proper version by the user." >> /root/PLUGIN_INFO


# Enable services
sysrc lighttpd_enable=YES
sysrc php_fpm_enable=YES
# Enable SSL with a self signed cert. It is mandatory for Chrome to work with PrivateBin
openssl req -new -newkey rsa:4096 -days 18250 -nodes -x509 \
    -subj "/C=privatebin/ST=privatebin/L=privatebin/O=privatebin/CN=privatebin" \
    -keyout privatebin.key  -out privatebin.cert
# Wait for SSL to finish its thing
sleep 10
cat privatebin.key privatebin.cert > privatebin.pem
sleep 5
mv privatebin.pem /etc/ssl/privatebin.pem
rm privatebin.key 
rm privatebin.cert
# Start services
service php-fpm start
service lighttpd start

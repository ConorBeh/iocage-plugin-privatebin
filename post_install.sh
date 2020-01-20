# Enable services
sysrc lighttpd_enable=YES
sysrc php_fpm_enable=YES
# Enable SSL with a self signed cert. It is mandatory for Chrome to work with PrivateBin
#openssl genrsa -rand -genkey -out cert.key 2048
#openssl req -new -x509 -days 365 -key cert.key -out cert.crt -sha256 -subj "/C=US/ST=PB/L=pbin/O=pbin/CN=pbin" -keyout www.example.com.key  -out www.example.com.cert
cd /etc/ssl
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=PB/L=pbin/O=pbin/CN=pbin" -keyout privatebin.key -out privatebin.cert
# Wait for SSL to finish its thing
sleep 10
#cat privatebin.key privatebin.cert > privatebin.pem
#sleep 5
#mv privatebin.pem /etc/ssl/privatebin.pem
#rm privatebin.key 
#rm privatebin.cert
# Start services
service php-fpm start
service lighttpd start

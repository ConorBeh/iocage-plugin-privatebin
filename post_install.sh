# Enable services
sysrc lighttpd_enable=YES
sysrc php_fpm_enable=YES

# Start services
service php-fpm start
service lighttpd start

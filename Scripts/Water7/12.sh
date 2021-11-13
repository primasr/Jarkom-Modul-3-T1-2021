echo '
acl PNG url_regex .png
acl JPG url_regex .jpg

acl LUFFY src 10.42.1.0/24
acl ZORO src 10.42.3.0/24

delay_pools 2

delay_class 1 1
delay_access 1 allow LUFFY
delay_parameters 1 10000/10000

delay_class 2 1
delay_access 2 allow ZORO
delay_parameters 2 none
' > /etc/squid/acl-bandwidth.conf

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

echo '
include /etc/squid/acl.conf
include /etc/squid/acl-bandwidth.conf
http_port 5000
visible_hostname Water7

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
http_access allow USERS AVAILABLE_WORKING

dns_nameservers 10.42.2.2

http_access deny all
' > /etc/squid/squid.conf

service squid restart

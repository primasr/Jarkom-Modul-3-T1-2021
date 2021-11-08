echo '
acl AVAILABLE_WORKING time MTWH 07:00-11:00
acl AVAILABLE_WORKING time TWHF 17:00-24:00
acl AVAILABLE_WORKING time WHFA 00:00-03:00
' > /etc/squid/acl.conf

echo '
include /etc/squid/acl.conf
http_port 5000
visible_hostname Water7

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
http_access allow USERS
http_access allow AVAILABLE_WORKING
http_access deny all
' > /etc/squid/squid.conf

service squid restart

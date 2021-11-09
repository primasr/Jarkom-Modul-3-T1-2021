echo '
include /etc/squid/acl.conf
http_port 5000
visible_hostname Water7

acl badsites dstdomain .google.com
deny_info http://super.franky.ti1.com badsites all
http_reply_access deny badsites all

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
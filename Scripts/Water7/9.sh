htpasswd -c -b -m /etc/squid/passwd luffybelikapalti1 luffy_ti1
htpasswd -b -m /etc/squid/passwd zorobelikapalti1 zoro_ti1

echo '
http_port 5000
visible_hostname Water7

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
http_access allow USERS
' > /etc/squid/squid.conf

service squid restart

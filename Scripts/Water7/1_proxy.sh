mv /etc/squid/squid.conf /etc/squid/squid.conf.bak

echo '
http_port 8080
visible_hostname Water7

http_access allow all
' > /etc/squid/squid.conf

service squid restart

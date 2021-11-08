echo '
http_port 5000
visible_hostname Water7

http_access allow all
' > /etc/squid/squid.conf

service squid restart
echo '
net.ipv4.ip_forward=1
' > /etc/sysctl.conf

sysctl -p

apt-get install isc-dhcp-relay -y
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install squid -y
apt-get install apache2-utils -y
apt-get install ca-certificates openssl -y
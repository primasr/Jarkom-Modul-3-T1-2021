echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install dnsutils -y
apt-get install lynx -y
apt-get install ca-certificates openssl -y
apt-get install speedtest-cli -y
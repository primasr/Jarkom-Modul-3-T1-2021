if [[ $(hostname) = "Foosha" ]]; then
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.42.0.0/16
apt-get update
apt-get install nano
apt-get install isc-dhcp-server -y

echo '
INTERFACES="eth1"
' > /etc/default/isc-dhcp-server

rm /etc/dhcp/dhcpd.conf

echo '
subnet 10.42.1.0 netmask 255.255.255.0 {
    range 10.42.1.7 10.42.1.30;
    option routers 10.42.1.1;
    option broadcast-address 10.42.1.255;
    option domain-name-servers 202.46.129.2;
    default-lease-time 600;
    max-lease-time 7200;
}
' > /etc/dhcp/dhcpd.conf

# restart 2x, siapa tahu error :)
service isc-dhcp-server restart
service isc-dhcp-server restart

echo '
subnet 10.42.1.0 netmask 255.255.255.0 {
    range 10.42.1.7 10.42.1.30;
    option routers 10.42.1.1;
    option broadcast-address 10.42.1.255;
    option domain-name-servers 202.46.129.2;
    default-lease-time 600;
    max-lease-time 7200;
}

host Jipangu {
    hardware ethernet ce:87:9a:4f:3f:ad; # hardware Jipangu
    fixed-address 10.42.1.13;
}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart
fi

if [[ $(hostname) = "Loguetown" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano

echo '
auto eth0
iface eth0 inet dhcp
' > /etc/network/interfaces
fi

if [[ $(hostname) = "Alabasta" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano

echo '
auto eth0
iface eth0 inet dhcp
' > /etc/network/interfaces
fi

if [[ $(hostname) = "Jipangu" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano

echo '
auto eth0
iface eth0 inet dhcp
' > /etc/network/interfaces

echo '
auto eth0
iface eth0 inet dhcp
hwaddress ether ce:87:9a:4f:3f:ad
' > /etc/network/interfaces
fi

if [[ $(hostname) = "Enieslobby" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install bind9 -y
fi

if [[ $(hostname) = "Water7" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
apt-get install squid -y
fi
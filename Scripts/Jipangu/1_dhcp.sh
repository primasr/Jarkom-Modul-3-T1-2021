echo '
INTERFACES="eth0"
' > /etc/default/isc-dhcp-server

rm /etc/dhcp/dhcpd.conf

echo '

# SWITCH 2
subnet 10.42.2.0 netmask 255.255.255.248 {
}

# SWITCH 1
subnet 10.42.1.0 netmask 255.255.255.0 {
    range 10.42.1.20 10.42.1.99;
    range 10.42.1.150 10.42.1.169;
    option routers 10.42.1.1;
    option broadcast-address 10.42.1.255;
    option domain-name-servers 10.42.2.2;
    default-lease-time 360; # 6 menit
    max-lease-time 7200; # 120 menit
}

# SWITCH 3
subnet 10.42.3.0 netmask 255.255.255.0 {
    range 10.42.3.30 10.42.3.50;
    option routers 10.42.3.1;
    option broadcast-address 10.42.3.255;
    option domain-name-servers 10.42.2.2;
    default-lease-time 720; # 12 menit
    max-lease-time 7200; # 120 menit
}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart
service isc-dhcp-server restart



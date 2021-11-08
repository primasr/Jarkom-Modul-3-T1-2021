if [[ $(hostname) = "Foosha" ]]; then
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.42.0.0/16
apt-get update
apt-get install nano
fi

if [[ $(hostname) = "Loguetown" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
fi

if [[ $(hostname) = "Alabasta" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
fi

if [[ $(hostname) = "Enieslobby" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
fi

if [[ $(hostname) = "Water7" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
fi

if [[ $(hostname) = "Jipangu" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
fi

if [[ $(hostname) = "Tottoland" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
fi

if [[ $(hostname) = "Skypie" ]]; then
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install nano
fi


echo '
zone "franky.ti1.com" {
        type master;
        file "/etc/bind/kaizoku/franky.ti1.com";
};
' > /etc/bind/named.conf.local

echo '
options {
directory "/var/cache/bind";

//dnssec-validation auto;

allow-query{any;};
auth-nxdomain no;    # conform to RFC1035
listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

mkdir -p /etc/bind/kaizoku
cp /etc/bind/db.local /etc/bind/kaizoku/franky.ti1.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     franky.ti1.com. root.franky.ti1.com. (
                        2021100401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      franky.ti1.com.
@       IN      A       10.42.2.2
' > /etc/bind/kaizoku/franky.ti1.com

service bind9 restart
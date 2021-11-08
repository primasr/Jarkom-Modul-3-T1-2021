echo '
zone "franky.ti1.com" {
        type master;
        file "/etc/bind/kaizoku/franky.ti1.com";
};

zone "2.42.10.in-addr.arpa" {
    type master;
    file "/etc/bind/kaizoku/2.42.10.in-addr.arpa";
};
' > /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/kaizoku/2.42.10.in-addr.arpa

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
2.42.10.in-addr.arpa.   IN      NS      franky.ti1.com.
2                       IN      PTR     franky.ti1.com.
' > /etc/bind/kaizoku/2.42.10.in-addr.arpa

service bind9 restart


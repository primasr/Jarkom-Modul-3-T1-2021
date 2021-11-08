echo '
zone "jualbelikapal.ti1.com" {
        type master;
        file "/etc/bind/kaizoku/jualbelikapal.ti1.com";
};
' > /etc/bind/named.conf.local

mkdir -p /etc/bind/kaizoku
cp /etc/bind/db.local /etc/bind/kaizoku/jualbelikapal.ti1.com

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     jualbelikapal.ti1.com. root.jualbelikapal.ti1.com. (
                        2021100401      ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      jualbelikapal.ti1.com.
@       IN      A       10.42.2.3   # IP Water7
' > /etc/bind/kaizoku/jualbelikapal.ti1.com

service bind9 restart
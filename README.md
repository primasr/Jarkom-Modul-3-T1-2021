# Jarkom-Modul-3-T1-2021

## Anggota Kelompok

- Prima Secondary Ramadhan  05311940000001
- Asiyah Hanifah            05311940000002
- Widya Inayatul            05311940000010
---
## Soal 1-6
Luffy yang sudah menjadi Raja Bajak Laut ingin mengembangkan daerah kekuasaannya dengan membuat peta seperti berikut:
(gambar 0.0)
Luffy bersama Zoro berencana membuat peta tersebut dengan kriteria EniesLobby sebagai DNS Server, Jipangu sebagai DHCP Server, Water7 sebagai Proxy Server(1), dan Foosha sebagai DHCP Relay (2). Luffy dan Zoro menyusun peta tersebut dengan hati-hati dan teliti.

Ada beberapa kriteria yang ingin dibuat oleh Luffy dan Zoro, yaitu:
1. Semua client yang ada HARUS menggunakan konfigurasi IP dari DHCP Server.
2. Client yang melalui Switch1 mendapatkan range IP dari [prefix IP].1.20 - [prefix IP].1.99 dan [prefix IP].1.150 - [prefix IP].1.169 (3)
3. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.30 - [prefix IP].3.50 (4)
4. Client mendapatkan DNS dari EniesLobby dan client dapat terhubung dengan internet melalui DNS tersebut. (5)
5. Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 6 menit sedangkan pada client yang melalui Switch3 selama 12 menit. Dengan waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 120 menit. (6)
## Jawaban
Sebelum mengerjakan soal ini, kami membuat topologinya sebagai berikut.
![1.0](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.0.png?raw=true)
- Dengan konfigurasi pada Foosha:
![1.1](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.1.png?raw=true)
![1.1.1](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.1.1.png?raw=true)
- Konfigurasi pada Loguetown:
![1.2](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.2.png?raw=true)
- Konfigurasi pada Alabasta:
![1.3](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.3.png?raw=true)
- Konfigurasi pada Enieslobby:
![1.4](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.4.png?raw=true)
- Konfigurasi pada Water7:
![1.5](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.5.png?raw=true)
- Konfigurasi pada Jipangu:
![1.6](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.6.png?raw=true)
- Konfigurasi pada Tottoland:
![1.7](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.7.png?raw=true)
- Dan Konfigurasi pada Skypie:
![1.8](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.8.png?raw=true)
Pada nomer 1, diminta untuk menjadikan Enieslobby sebagai DNS Server, Jipangu sebagai DHCP Server, dan Water7 sebagai proxy server. Sedangkan pada nomer 2 diminta untuk menjadikan foosha sebagai DHCP Relay. sebagai berikut.

a. Di Enieslobby kami melakukan instalasi bind9 terlebih dahulu untuk menjadikannya sebagai DNS Server.
```
apt-get update
apt-get install bind9 -y
```
kemudian Kmi melakukan membuat domain franky.ti1.com di /etc/bind/named.conf.local dan mengisi konfigurasinya seperti berikut.
```
zone "franky.ti1.com" {
    	type master;
    	file "/etc/bind/kaizoku/franky.ti1.com";
};
```
setelahnya, kami membuat folder kaizoku dengan ```mkdir -p /etc/bind/kaizoku```. Kemudian kami mengopykan db.local pada path /etc/bind ke dalam folder kaizoku yang baru saja dibuat dan ubah namanya menjadi frankyti1.com dengan command: ```cp /etc/bind/db.local /etc/bind/kaizoku/franky.ti1.com```

Kami membuka file frankyti1.com dan edit seperti gambar berikut disesuaikan dengan IP Ennieslobby kami dengan command nano /etc/bind/kaizoku/franky.ti1.com sebagai berikut.
```
;
; BIND data file for local loopback interface
;
$TTL	604800
@   	IN  	SOA 	franky.ti1.com. root.franky.ti1.com. (
                    	2021100401  	; Serial
                     	604800     	; Refresh
                      	86400     	; Retry
                    	2419200     	; Expire
                     	604800 )   	; Negative Cache TTL
;
@   	IN  	NS  	franky.ti1.com.
@   	IN  	A   	10.42.2.2
```
Selain menambahkan DNS Server, kami juga membuat Reverse DNS pada Enieslobby dengan menambahkan konfigurasinya untuk reverse domain utama dengan membalik IP Eniesloby di ```/etc/bind/named.conf.local ``` seperti berikut.
```
zone "2.42.10.in-addr.arpa" {
	type master;
	file "/etc/bind/kaizoku/2.42.10.in-addr.arpa";
};
```
Kemudian kami melakukan copy file db.local pada path /etc/bind ke dalam folder kaizoku yang baru saja dibuat dan ubah namanya menjadi 2.40.10.in-addr.arpa dengan command: ```cp /etc/bind/db.local /etc/bind/kaizoku/2.42.10.in-addr.arpa```

Dan mengedit file ```/etc/bind/kaizoku/2.42.10.in-addr.arpa``` seperti berikut.
```
;
; BIND data file for local loopback interface
;
$TTL	604800
@   	IN  	SOA 	franky.ti1.com. root.franky.ti1.com. (
                    	2021100401  	; Serial
                     	604800     	; Refresh
                      	86400     	; Retry
                    	2419200     	; Expire
                     	604800 )   	; Negative Cache TTL
;
2.42.10.in-addr.arpa.   IN  	NS  	franky.ti1.com.
2                   	IN  	PTR 	franky.ti1.com.
```
kemudian dilakukan service restart dengan command: ```service bind9 restart```

b. Pada Loguetown dilakukan pengecekan terhadap DNS Server yang telah dibuat dengan mengatur bagian ```/etc/resolv.conf``` untuk menambahkan nameserver dengan IP yang mengarah ke Enieslobby dengan command: ```nameserver 10.42.2.2```. Kemudian lakukan ping ke franky .ti1.com sebagai berikut.
```ping franky.ti1.com```

![1.9](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.9.png?raw=true)

Sedangkan untuk pengecekan Reverse DNS, Loguetown harus melakukan instalasi dsutils dengan command: ```apt-get install dnsutils -y```. Kemudian untuk mengeceknya bisa mengetikkan command: ```host -t PTR 10.42.2.2```

![1.10](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/1.10.png?raw=true)

c. Kemudian kami mennjadikan Foosha sebagai DHCP relay dengan mengatur konfigurasi pada ```/etc/sysctl.conf``` di Foosha dengan command ```net.ipv4.ip_forward=1```. kemudian melakukan command ```sysctl -p```. kemudian mengintsall dhcp relay dengan command ``` apt-get install isc-dhcp-relay -y```.

Saat menginstall kami diminta untuk memasukkan ip server yang akan menjadi target dhcp saat melakukan request, di sini kami memasukkan IP Jipangu (10.42.2.3) sebagai DHCP Sever. Untuk INTERFACES= diisi dengan ```eth1 eth3 eth2``` , karena pada DHCP relay (Foosha) akan meneruskan DHCP request dari network interface eth1 dan eth3, lalu meneruskannya ke DHCP server melalui eth2. Setelah itu service dapat direstart dengan command ```service isc-dhcp relay restart```

c. Sedangkan pada Jipangu yang akan bertindak sebagai DHCP Server kami menginstall dahulu dhcp servernyanya dengan command: ```apt-get install isc-dhcp-server -y``` kemudian edit konfigurasi interfacesnya pada ```/etc/default/isc-dhcp-server``` dengan ``` INTERFACE="eth0"``` untuk memberikan layanan DHCP pada interface eth 0.

Kemudian kami hapus semua konfigurasi pada ```/etc/dhcp/dhcpd.conf``` untuk mengatur ulang konfigurasinya sesuai dengan konfigurasi kriteria yang diinginkan soal nomer 3 dan 4 dimana Client yang melalui Switch1 mendapatkan range IP dari 10.42.1.20 - 10.42.1.99 dan 10.42.1.150 - 10.42.1.169 dan Client yang melalui Switch3 mendapatkan range IP dari 10.42.3.30 - 10.42.3.50.

Supaya Loguetown mendapatkan DNS dari EniesLobby dan Loguetown dapat terhubung dengan internet melalui DNS tersebut seperti kriteria soal nomer 5 kami menambahkan ```option domain-name-servers 10.42.2.2``` dengan IPnya Enieslobby sebagai DNS Servernya.

Selain itu kami juga mengatur Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch1 selama 6 menit dengan ```default-lease-time 360; # 6 menit```sedangkan pada client yang melalui Switch3 selama 12 menit ```default-lease-time 720; # 12 menit```. Dengan waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 120 menit dengan ```max-lease-time 7200; ``` seperti nomer 6. Dengan mengeditnya seperti berikut.
```
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
```
Kemudian lakukan service restart dengan command: ```service isc-dhcp-server restart```

d. Untuk mengeceknya, pada Loguetown kami edit konfigurasi interfacenya di ```/etc/network/interfaces``` dengan command:
```
auto eth0
iface eth0 inet dhcp
```
Setelah itu, liat pada node Logutown. Dan coba stop node dan nyalakan kembali dengan cara: Klik Kanan `Loguetown` > Stop > Start Lagi.

![5.0](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/5.0.png?raw=true)

![5.1](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/5.1.png?raw=true)

![5.2](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/5.2.png?raw=true)

Dapat dilihat loguetown mendapatkan DNS dari IP Enieslobby dengan IP nya yang terlihat di Loguetown sebagai berikut.

![5.3](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/5.3.png?raw=true)

e. Kemudian pada Water7 kami buat Proxy servernya, namun sebelum itu kami melakukan instalasi squid terlebih dahulu. dengan command: ```apt-get install squid``` kemudian cek status squid dengan ```service squid status``` kemudian kami melakukan backup pada squidnya dengan ```mv /etc/squid/squid.conf /etc/squid/squid.conf.bak``` dan membuat konfigurasi Squid baru Pada file ```/etc/squid/squid.conf``` dengan script
```
http_port 8080
visible_hostname Water7

http_access allow all
```
http_access allow all dilakukan supaya bisa mengakses web. Kemudian kami melakukan restart pada service dengan ```service squid restart```

f. pada Untuk mengecek proxy servernya, pada Loguetown kami melakukan pengaktifan dulu pada proxynya dengan ```export http_proxy="http://10.42.2.3:8080" ``` dengan IP nya Water7 sebagai Proxynya. Untuk memeriksa apakah konfigurasi proxy pada Loguetown berhasil kami melakukan perintah ```env | grep -i proxy```. Kemudian kami juga dapat dilakukan ```unset http_proxy``` jika ingin menonaktifkan proxy. Hasilnya dapat dilihat seperti gambar berikut.

![6.0](https://github.com/primasr/Jarkom-Modul-3-T1-2021/blob/main/Images/6.0.png?raw=true)

## Soal 7
Luffy dan Zoro berencana menjadikan Skypie sebagai server untuk jual beli kapal yang dimilikinya dengan alamat IP yang tetap dengan IP [prefix IP].3.69
## Jawaban

a. Pada Jipangu di ```/etc/dhcp/dhcpd.conf``` skypie akan mendapatkan IP tetap 10.42.3.69 seperti yang ditambahkan pada script berikut 
```
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
host Skypie {
	hardware ethernet 3e:2a:81:99:1f:ad;
	fixed-address 10.42.3.69;
}
```
sebelumnya untuk mengetahui hwaddress milik skypie menggunakan perintah ```ip a``` lalu dilakukan restart service  ```isc-dhcp-server restart```

b. Pada Skypie edit konfigurasi di ```/etc/network/interfaces``` seperti berikut 
```
auto eth0
iface eth0 inet dhcp

hwaddress ether 3e:2a:81:99:1f:ad
```
ditambahkan hwaddress skypie ```hardware ethernet 3e:2a:81:99:1f:ad``` lalu dilakukan restart node dan testing dengan perintah ```ip a```

## Soal 8
Loguetown digunakan sebagai client Proxy agar transaksi jual beli dapat terjamin keamanannya, juga untuk mencegah kebocoran data transaksi. Pada Loguetown, proxy harus bisa diakses dengan nama jualbelikapal.yyy.com dengan port yang digunakan adalah 5000
## Jawaban

a. Pada enieslooby di ```/etc/bind/named.conf.local``` edit konfigurasi seperti berikut
```
zone "jualbelikapal.ti1.com" {
    	type master;
    	file "/etc/bind/kaizoku/jualbelikapal.ti1.com";
};
```
setelah itu membuat file di folder kaizoku ```mkdir -p /etc/bind/kaizoku``` Kemudian copy file db.local pada path /etc/bind ke dalam folder kaizoku dan ubah namanya menjadi jualbelikapal.ti1.com dengan command: ```cp /etc/bind/db.local /etc/bind/kaizoku/jualbelikapal.ti1.com```.

Lalu mengedit konfigurasi di ``` /etc/bind/kaizoku/jualbelikapal.ti1.com``` seperti berikut :
```
;
; BIND data file for local loopback interface
;
$TTL	604800
@   	IN  	SOA 	jualbelikapal.ti1.com. root.jualbelikapal.ti1.com. (
                    	2021100401  	; Serial
                     	604800     	; Refresh
                      	86400     	; Retry
                    	2419200     	; Expire
                     	604800 )   	; Negative Cache TTL
;
@   	IN  	NS  	jualbelikapal.ti1.com.
@   	IN  	A   	10.42.2.3   # IP Water7
```
kemudian direstart ```service bind9 restart```

b. Pada water 7 di ```/etc/squid/squid.conf``` diedit konfigurasi dengan port yang digunakan untuk mengakses proxy adalah 5000 dan supaya bisa mengakses web jualbelikapal.ti1.com maka ditambahkan ```http_access allow all``` seperti berikut:
```
http_port 5000
visible_hostname Water7
http_access allow all
```
Lalu restart squid dengan perintah ```service squid restart```.

b. Pada Loguetown akan diaktifkan proxy dengan perintah 
```
export http_proxy="http://jualbelikapal.ti1.com:5000"
```  
dan untuk memeriksa apakah konfigurasi proxy pada client berhasil menggunakan perintah ```env | grep -i proxy```

## Soal 9
Agar transaksi jual beli lebih aman dan pengguna website ada dua orang, proxy dipasang autentikasi user proxy dengan enkripsi MD5 dengan dua username, yaitu luffybelikapalyyy dengan password luffy_yyy dan zorobelikapalyyy dengan password zoro_yyy
## Jawaban

a. Pada Water7 dilakukan instal apache2-utils ```apt-get install apache2-utils -y``` dan dibuat autentifikasi user proxy dengan enkripsi MD5 pada username luffybelikapalti1 dan password luffy_ti1 dengan perintah: 
```
htpasswd -c -b -m /etc/squid/passwd luffybelikapalti1 luffy_ti1
```
pada username zorobelikapalti1 dan password zoro_ti1 dengan perintah: 
```
htpasswd -b -m /etc/squid/passwd zorobelikapalti1 zoro_ti1
```
Kemudian dilakukan edit konfigurasi di ```/etc/squid/squid.conf``` seperti berikut:
```
http_port 5000
visible_hostname Water7

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
http_access allow USERS
```
dan dilakukan restart squid ```service squid restart```. 

b. Pada Loguetown dilakukan testing untuk mengakses web dengan perintah ```lynx http://its.ac.id```.

## Soal 10
Transaksi jual beli tidak dilakukan setiap hari, oleh karena itu akses internet dibatasi hanya dapat diakses setiap hari Senin-Kamis pukul 07.00-11.00 dan setiap hari Selasa-Jum’at pukul 17.00-03.00 keesokan harinya (sampai Sabtu pukul 03.00)
## Jawaban

a. Pada Water7 dilakukan edit konfigurasi di ```/etc/squid/acl.conf``` agar pembatasan akses internet berjalan sesuai jam yang sudah ditetapkan seperti berikut:
```
acl AVAILABLE_WORKING time MTWH 07:00-11:00
acl AVAILABLE_WORKING time TWHF 17:00-24:00
acl AVAILABLE_WORKING time WHFA 00:00-03:00
```
kemudian di ```/etc/squid/squid.conf``` dilakukan edit konfigurasi dengan menambahkan ```http_access allow USERS AVAILABLE_WORKING``` dan ```http_access deny all``` seperti berikut:
```
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
http_access allow USERS AVAILABLE_WORKING
http_access deny all
```
dan dilakukan restart ```service squid restart```

b. Pada Loguetown dilakukan testing pembatasan akses internet pada web its dengan perintah ```date -s "7 NOV 2021 09:00:00"``` dan ```lynx http://its.ac.id/```


## Soal 11
Agar transaksi bisa lebih fokus berjalan, maka dilakukan redirect website agar mudah mengingat website transaksi jual beli kapal. Setiap mengakses google.com, akan diredirect menuju super.franky.yyy.com dengan website yang sama pada soal shift modul 2. Web server super.franky.yyy.com berada pada node Skypie
## Jawaban

a. Pada enieslobby di ```/etc/bind/named.conf.local``` dilakukan edit konfigurasi seperti berikut:
```
zone "jualbelikapal.ti1.com" {
    	type master;
    	file "/etc/bind/kaizoku/jualbelikapal.ti1.com";
};

zone "super.franky.ti1.com" {
    	type master;
    	file "/etc/bind/kaizoku/super.franky.ti1.com";
};
```
kemudian membuat file di kaizoku ```mkdir -p /etc/bind/kaizoku``` lalu melakukan copy file db.local pada path /etc/bind ke dalam folder kaizoku dan ubah namanya menjadi super.franky.ti1.com dengan command: ```cp /etc/bind/db.local /etc/bind/kaizoku/super.franky.ti1.com```

pada ```/etc/bind/kaizoku/super.franky.ti1.com``` dilakukan edit konfigurasi seperti berikut:
```
;
; BIND data file for local loopback interface
;
$TTL	604800
@   	IN  	SOA 	super.franky.ti1.com. root.super.franky.ti1.com. (
                    	2021100401  	; Serial
                     	604800     	; Refresh
                      	86400     	; Retry
                    	2419200     	; Expire
                     	604800 )   	; Negative Cache TTL
;
@   	IN  	NS  	super.franky.ti1.com.
@   	IN  	A   	10.42.3.69 ; IP Skypie
```
kemudian dilakukan restart ```service bind9 restart```

b. Pada Skypie mendownload file  dan menyimpannya di direktori dengan perintah:
```
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/super.franky.zip -O /root/super.franky.zip
```
kemudian membuat folder ```mkdir /var/www/super.franky.ti1.com``` dan unzip file dengan perintah ```unzip -o /root/super.franky.zip -d /root```. melakukan copyfile ```cp -r /root/super.franky/. /var/www/super.franky.ti1.com/``` 

kemudian edit konfigurasi di ```/etc/apache2/sites-available/super.franky.ti1.com.conf``` seperti berikut:
```
<VirtualHost *:80>
    	ServerAdmin webmaster@localhost
    	DocumentRoot /var/www/super.franky.ti1.com
    	ServerName super.franky.ti1.com

    	<Directory /var/www/super.franky.ti1.com>
        	Options +FollowSymLinks -Multiviews
        	AllowOverride All
    	</Directory>

    	<Directory /var/www/super.franky.ti1.com/public>
        	Options +Indexes
    	</Directory>

    	Alias "/index.php" "/var/www/super.franky.ti1.com/index.php"

    	ErrorDocument 404 /error/404.html
    	ErrorDocument 500 /error/404.html
    	ErrorDocument 502 /error/404.html
    	ErrorDocument 503 /error/404.html
    	ErrorDocument 504 /error/404.html

    	<Directory /var/www/super.franky.ti1.com/public/js>
        	Options +Indexes
    	</Directory>
   	 
    	Alias "/js" "/var/www/super.franky.ti1.com/public/js"

    	ErrorLog ${APACHE_LOG_DIR}/error.log
    	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
lalu mengaktifkan konfigurasi dengan perintah ```a2ensite super.franky.ti1.com``` dan melakukan restart ```service apache2 restart```.

b. Pada Water7 edit konfigurasi squid di ``` /etc/squid/squid.conf``` ditambahkan ```dns_nameservers 10.42.2.2``` seperti berikut:
```
include /etc/squid/acl.conf
http_port 5000
visible_hostname Water7

auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 5
auth_param basic realm Proxy
auth_param basic credentialsttl 2 hours
auth_param basic casesensitive on
acl USERS proxy_auth REQUIRED
http_access allow USERS AVAILABLE_WORKING

dns_nameservers 10.42.2.2

http_access deny all
```
dan restart squid ```service squid restart```.

c. Pada Loguetown melakukan testing untuk mengakses google.com, akan diredirect menuju super.franky.ti1.com dengan perintah 
```
lynx http://super.franky.ti1.com
lynx google.com
```

## Soal 12
Saatnya berlayar! Luffy dan Zoro akhirnya memutuskan untuk berlayar untuk mencari harta karun di super.franky.yyy.com. Tugas pencarian dibagi menjadi dua misi, Luffy bertugas untuk mendapatkan gambar (.png, .jpg), sedangkan Zoro mencari sisanya. Karena Luffy orangnya sangat teliti untuk mencari harta karun, ketika ia berhasil mendapatkan gambar, ia mendapatkan gambar dan melihatnya dengan kecepatan 10 kbps
## Jawaban
## Soal 13
Sedangkan, Zoro yang sangat bersemangat untuk mencari harta karun, sehingga kecepatan kapal Zoro tidak dibatasi ketika sudah mendapatkan harta yang diinginkannya
## Jawaban

## Kendala
kesulitan menyelesaikan soal 12 dan 13

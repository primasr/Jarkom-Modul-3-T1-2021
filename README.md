# Jarkom-Modul-3-T1-2021

## Anggota Kelompok

- Prima Secondary Ramadhan  05311940000001
- Asiyah Hanifah            05311940000002
- Widya Inayatul            053119400000xx
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
(gambar 1.0)
- Dengan konfigurasi pada Foosha:
(gambar 1.2)
- Konfigurasi pada Loguetown:
(gambar 1.3)
- Konfigurasi pada Alabasta:
(gambar 1.4)
- Konfigurasi pada Enieslobby:
(gambar 1.5)
- Konfigurasi pada Water7:
(gambar 1.6)
- Konfigurasi pada Jipangu:
(gambar 1.7)
- Konfigurasi pada Tottoland:
(gambar 1.8)
- Dan Konfigurasi pada Skypie:
(gambar 1.9)
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

b. Pada Loguetown dilakukan pengecekan terhadap DNS Server yang telah dibuat dengan mengatur bagian ```/etc/resolv.conf``` untuk menambahkan nameserver dengan IP yang mengarah ke Enieslobby dengan command: ```nameserver 10.42.2.2``. Kemudian lakukan ping ke franky .ti1.com sebagai berikut.
```ping -c 3 franky.ti1.com```
(gambar 1.10)
Sedangkan untuk pengecekan Reverse DNS, Loguetown harus melakukan instalasi dsutils dengan command: ```apt-get install dnsutils -y```. Kemudian untuk mengeceknya bisa mengetikkan command: ```host -t PTR 10.42.2.2```

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
(Gambar 5.0)
Dapat dilihat loguetown mendapatkan DNS dari IP Enieslobby dengan IP nya yang terlihat di Loguetown sebagai berikut.
(gambar 5.1).

e. Kemudian pada Water7 kami buat Proxy servernya, namun sebelum itu kami melakukan instalasi squid terlebih dahulu. dengan command: ```apt-get install squid``` kemudian cek status squid dengan ```service squid status``` kemudian kami melakukan backup pada squidnya dengan ```mv /etc/squid/squid.conf /etc/squid/squid.conf.bak``` dan membuat konfigurasi Squid baru Pada file ```/etc/squid/squid.conf``` dengan script
```
http_port 8080
visible_hostname Water7

http_access allow all
```
http_access allow all dilakukan supaya bisa mengakses web. Kemudian kami melakukan restart pada service dengan ```service squid restart```

f. pada Untuk mengecek proxy servernya, pada Loguetown kami melakukan pengaktifan dulu pada proxynya dengan ```export http_proxy="http://10.42.2.3:8080" ``` dengan IP nya Water7 sebagai Proxynya. Untuk memeriksa apakah konfigurasi proxy pada Loguetown berhasil kami melakukan perintah ```env | grep -i proxy```. Kemudian kami lakukan ```unset http_proxy``` untuk menonaktifkan proxy. Hasilnya dapat dilihat seperti gambar berikut.
(Gambar 6.0)
## Soal 7
Luffy dan Zoro berencana menjadikan Skypie sebagai server untuk jual beli kapal yang dimilikinya dengan alamat IP yang tetap dengan IP [prefix IP].3.69
## Jawaban
Pada soal nomer satu, kami diminta untuk  membuat Enieslobby sebagai DNS Server, Jipangu sebagai DHCP Server, Water7 sebagai Proxy Server.
## Soal 8
Loguetown digunakan sebagai client Proxy agar transaksi jual beli dapat terjamin keamanannya, juga untuk mencegah kebocoran data transaksi. Pada Loguetown, proxy harus bisa diakses dengan nama jualbelikapal.yyy.com dengan port yang digunakan adalah 5000
## Jawaban
## Soal 9
Agar transaksi jual beli lebih aman dan pengguna website ada dua orang, proxy dipasang autentikasi user proxy dengan enkripsi MD5 dengan dua username, yaitu luffybelikapalyyy dengan password luffy_yyy dan zorobelikapalyyy dengan password zoro_yyy
## Jawaban
## Soal 10
Transaksi jual beli tidak dilakukan setiap hari, oleh karena itu akses internet dibatasi hanya dapat diakses setiap hari Senin-Kamis pukul 07.00-11.00 dan setiap hari Selasa-Jum’at pukul 17.00-03.00 keesokan harinya (sampai Sabtu pukul 03.00)
## Jawaban
## Soal 11
Agar transaksi bisa lebih fokus berjalan, maka dilakukan redirect website agar mudah mengingat website transaksi jual beli kapal. Setiap mengakses google.com, akan diredirect menuju super.franky.yyy.com dengan website yang sama pada soal shift modul 2. Web server super.franky.yyy.com berada pada node Skypie
## Jawaban
## Soal 12
Saatnya berlayar! Luffy dan Zoro akhirnya memutuskan untuk berlayar untuk mencari harta karun di super.franky.yyy.com. Tugas pencarian dibagi menjadi dua misi, Luffy bertugas untuk mendapatkan gambar (.png, .jpg), sedangkan Zoro mencari sisanya. Karena Luffy orangnya sangat teliti untuk mencari harta karun, ketika ia berhasil mendapatkan gambar, ia mendapatkan gambar dan melihatnya dengan kecepatan 10 kbps
## Jawaban
## Soal 13
Sedangkan, Zoro yang sangat bersemangat untuk mencari harta karun, sehingga kecepatan kapal Zoro tidak dibatasi ketika sudah mendapatkan harta yang diinginkannya
## Jawaban

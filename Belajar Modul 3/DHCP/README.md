# DHCP

## 1. Instalasi ISC-DHCP-Server

> Foosha

```sh
apt-get update
apt-get install isc-dhcp-server
```

Cek sudah bisa atau belu,

```sh
dhcpd --version
```

## 2. Konfigurasi DHCP Server

### 2.1. Menentukan interface mana yang akan diberi layanan DHCP

> Foosha

```sh
nano /etc/default/isc-dhcp-server
```

Tambahkan `eth1` dibagian `INTERFACE=""`

### 2.2. Buka file konfigurasi DHCP dengan perintah

> Foosha

Mending remove aja semua. Karena di-default nya banyak konfigurasi

```sh
rm /etc/dhcp/dhcpd.conf
nano /etc/dhcp/dhcpd.conf
```

Isi dengan,

```sh
subnet 10.42.1.0 netmask 255.255.255.0 {
    range 10.42.1.7 10.42.1.30;
    option routers 10.42.1.1;
    option broadcast-address 10.42.1.255;
    option domain-name-servers 202.46.129.2;
    default-lease-time 600;
    max-lease-time 7200;
}
```

Lalu tinggal restart. Jika error, coba restart lagi

```sh
service isc-dhcp-server restart
```

Cek apakah sudah jalan

```sh
service isc-dhcp-server status
```

## 3. Konfigurasi DHCP Client

### 3.1 Mengonfigurasi Client

> Alabasta

Cek ip, Alabasta telah diberikan IP statis 192.168.1.3

```sh
ip a
```

```sh
nano /etc/network/interfaces
```

Replace dengan,

```sh
auto eth0
iface eth0 inet dhcp
```

Restart node `Alabasta`

```sh
Klik Kanan `Alabasta` > Stop > Start Lagi
```

<span style="font-weight: bold">NOTE :</span>

Awas, di /root/.bashrc pada node <span style="color: #ff4f4f"> JANGAN </span> `echo "nameserver 192.168.122.1 > /etc/resolv.conf"`

Karena, akan mereplace nameserver yang sudah disediakan oleh DHCP

### 3.2 Testing

Cek lagi. Seharusnya ip-nya berada di rentang yang kita tentukan di DHCP

```sh
ip a

# output : 
# 10.42.1.7 - 10.42.1.7
```

Cek juga namerservernya, seharusnya sama dengan namerserver yang kita tentukan di DHCP

```sh
cat /etc/resolv.conf

# output :
# nameserver 202.46.129.2
```

### 3.3 Lakukan kembali langkah - langkah di atas pada client Loguetown dan Jipangu

<span style="font-weight: bold">NOTE :</span>

Kita hapus lagi konfigurasi `namerserver` yang ada di /root/.bashrc

## 4. Fixed Address

### 4.1 Konfigurasi DHCP Server di router Foosha

> Foosha

Edit file,

```sh
/etc/dhcp/dhcpd.conf
```

Tambahkan `host Jipangu` agar jadi kek gini

Hardware Jipangi bisa didapatkan di node Jipangu dengan command `ip a` di bagian `link/ether`

```sh
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
```

Restart, 

```sh
service isc-dhcp-server restart
```

### 4.2 Tambahkan konfigurasi berikut

> Jipangu

Edit file,

```sh
nano /etc/network/interfaces
```

Tambahkan konfigurasi hingga jadi kek gini. Perlu disetting supaya tidak ganti `hwaddress` - nya

```sh
auto eth0
iface eth0 inet dhcp
hwaddress ether ce:87:9a:4f:3f:ad
```

### 4.3 Restart node Jipangu

```sh
Klik Kanan `Jipangu` > Stop > Start Lagi
```

### 4.4 Testing

> Jipangu

```sh
ip a
```

IP Jipangu sudah berubah menjadi 10.42.1.13 sesuai dengan Fixed Address yang diberikan oleh DHCP Server

## Menguji Konfigurasi DHCP pada Topologi

Setelah melakukan berbagai konfigurasi di atas, kalian bisa memastikan apakah DHCP Server kalian berhasil dengan cara:

1. Matikan semua node melalui halaman GNS3
2. Menyalakan kembali semua node
3. Lakukan perintah ip a pada setiap node

Jika node client berganti alamat IP sesuai dengan range yang telah dikonfigurasi pada DHCP Server dan Jipangu tetap mendapatkan IP 10.42.1.13, maka konfigurasi DHCP server kalian berhasil.

<span style="font-weight: bold">Note from me:</span>
1. Di `Foosha`, jangan lupa dibagian `/root/.bashrc` nanti dikasih `service isc-dhcp-server restart` 2x. Supaya ketika di reload semua node, sudah tersedia DHCP servernya

 

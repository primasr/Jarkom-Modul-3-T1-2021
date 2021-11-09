if [ ! -d "/root/super.franky" ] ; then
    wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/super.franky.zip -O /root/super.franky.zip
fi

mkdir /var/www/super.franky.ti1.com
unzip -o /root/super.franky.zip -d /root
cp -r /root/super.franky/. /var/www/super.franky.ti1.com/

echo '
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
' > /etc/apache2/sites-available/super.franky.ti1.com.conf

a2ensite super.franky.ti1.com

service apache2 restart

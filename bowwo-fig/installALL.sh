sudo apt-get update -y && sudo apt-get install -y apache2 php5 libapache2-mod-php5 php5-gd php5-curl libssh2-php php5-mysqlnd-ms

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password admin"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password admin"
sudo apt-get install -y mysql-server

mysql -uroot -padmin -e 'CREATE DATABASE wordpress;'
mysql -uroot -padmin -e 'CREATE USER admin@localhost IDENTIFIED BY "admin";'
mysql -uroot -padmin -e 'GRANT ALL PRIVILEGES ON wordpress.* TO admin@localhost;'
mysql -uroot -padmin -e 'FLUSH PRIVILEGES;'

sudo sed -i 's/expose_php = On/expose_php = Off/' /etc/php5/apache2/php.ini
sudo sed -i 's/allow_url_fopen = On/allow_url_fopen = Off/' /etc/php5/apache2/php.ini
sudo a2enmod rewrite

sudo wget --output-document=/etc/apache2/sites-enabled/000-default.conf  https://raw.githubusercontent.com/bowwowxx/CIRCLE/dev/bowwo-fig/wordpress.conf
sudo service apache2 restart


cd /tmp && wget http://wordpress.org/latest.tar.gz && tar xzvf latest.tar.gz wordpress
cd wordpress && sudo cp wp-config-sample.php wp-config.php
sudo sed -i 's/database_name_here/wordpress/' wp-config.php
sudo sed -i 's/username_here/admin/' wp-config.php
sudo sed -i 's/password_here/admin/' wp-config.php
sudo rsync -avz --delete . /var/www/html

sudo chown www-data:www-data -R /var/www/html/
sudo service apache2 restart

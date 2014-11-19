#!/bin/bash
pass=$(cat xxx)
echo $pass

rep ()
{
mysql -u root -p$pass -Bse "use wordpress;update wp_options SET option_value=REPLACE(option_value,'x.x.x.x', 'x.x.x.x');"
mysql -u root -p$pass -Bse "use wordpress;update wp_posts SET guid=REPLACE(guid,'x.x.x.x', 'x.x.x.x');"
mysql -u root -p$pass -Bse "use wordpress;update wp_posts SET post_content=REPLACE(post_content,'x.x.x.x', 'x.x.x.x');"
echo 'replace data done!'
}

echo 1. restore wordpress.
echo 2. restore alldb.
echo 3. exit the script.
echo -n "Enter your choice : "
read choice
case $choice in
1 ) 
mysql -u root -p$pass wordpress < /tmp/dump.sql
rep 
;;
2 ) 
mysql -u root -p$pass < /tmp/dumpall.sql
rep 
;;
* ) echo "cancel!" ;;
esac
echo choice $choice is done!..end
rm -f /tmp/*.sql
rm -f /tmp/load.sh
mysql -u root -p$pass -Bse "use wordpress;select * from wp_options limit 10;"
mysql -u root -p$pass -Bse "use wordpress;select guid from wp_posts limit 10;"


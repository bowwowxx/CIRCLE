#!/bin/bash
pass=$(docker exec circle cat xxx)
echo $pass
echo -n "1:dump wordpress 2:dump all db 3:cancel->" 
read check 
case $check in xxx
 1) 
 echo "dump wordpress" 
 docker exec circle mysqldump --user=root -p$pass wordpress > /tmp/dump.sql
 mv /tmp/dump.sql ./
 ;; 
 2) 
 echo "dump all db" 
 docker exec circle mysqldump --user=root -p$pass --all-databases > /tmp/dumpall.sql
 mv /tmp/dumpall.sql ./
 ;; 
 *) 
 echo "" 
 ;; 
esac 
echo 'done..'

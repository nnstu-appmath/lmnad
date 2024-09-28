#!/bin/bash

mysql_user=root
mysql_password=${MYSQL_ROOT_PASSWORD}

now=$(date +"%d_%m_%Y")

echo "--------------------------------------------------------------------------------------"

docker exec lmnad_web sh -c 'mkdir -p /root/backups'

docker exec lmnad_mysql sh -c '
    mkdir -p /root/backups &&
    rm -f /root/backups/* &&
    mysqldump --user=$1 --password=$2 --triggers --routines --databases lmnad_db | gzip > /root/backups/backup_$3.sql.gz ' sh "$mysql_user" "$mysql_password" "$now"

echo "Performed mysqldump and created compressed backup of the database."

docker cp lmnad_mysql:/root/backups/backup_$now.sql.gz /home/esinkirill/backups/

echo "Copied MySQL backup to /home/esinkirill/backups/."

docker exec lmnad_web sh -c '
    cd /lmnad/project/media &&
    tar -czf /root/backups/backup.lmnad_uploads_$1.tar.gz uploads/ ' sh "$now"
echo "Created compressed backup of media files."

docker cp lmnad_web:/root/backups/backup.lmnad_uploads_$now.tar.gz /home/esinkirill/backups/
echo "Copied media backup to /home/esinkirill/backups/."

docker exec lmnad_mysql sh -c ' rm -f /root/backups/* '
docker exec lmnad_web sh -c ' rm -f /root/backups/* '
echo "Removed temporary backup files from lmnad_web and lmnad_mysql containers."

rsync -avz /home/esinkirill/backups/ esinkirill@188.120.225.17:/home/esinkirill/backups/
echo "Copied backup files to the remote server."

ssh esinkirill@188.120.225.17 "find /home/esinkirill/backups/* -mmin +2820 -exec rm {} \;"
echo "Removed backup files older than 47 hours from the remote server."

find /home/esinkirill/backups/* -mmin +1380 -exec rm {} \;
echo "Removed backup files older than 23 hours from the local server."

echo "Backup completed at $(date)" >> /home/esinkirill/backup.log 2>&1

echo "--------------------------------------------------------------------------------------"


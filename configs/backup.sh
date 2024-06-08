#!/bin/bash

<<<<<<< HEAD
mysql_user=root
mysql_password=78910

now=$(date +"%d_%m_%Y")

docker exec lmnad_web sh -c 'mkdir -p /root/backups'
echo "Создана директория для резервных копий на контейнере lmnad_web."

docker exec lmnad_mysql sh -c '
    mkdir -p /root/backups &&
    rm -f /root/backups/* &&
    mysqldump --user=$1 --password=$2 --triggers --routines --databases lmnad_db | gzip > /root/backups/backup_$3.sql.gz' sh "$mysql_user" "$mysql_password" "$now"
echo "Выполнен mysqldump и создана сжатая резервная копия базы данных."

docker cp lmnad_mysql:/root/backups/backup_$now.sql.gz /tmp/
docker cp /tmp/backup_$now.sql.gz lmnad_web:/root/backups
echo "Скопирована сжатая резервная копия базы данных на контейнер lmnad_web."

docker exec lmnad_mysql sh -c 'rm -f /root/backups/*'
echo "Удалены временные файлы резервной копии базы данных на контейнере lmnad_mysql."

docker exec lmnad_web sh -c '
    cd /lmnad/project/media &&
    tar -czf /root/backups/backup.lmnad_uploads_$1.tar.gz uploads/ &&
    rsync -avz /root/backups/ esinkirill@188.120.225.17:/home/esinkirill/backups/ &&
    ssh esinkirill@188.120.225.17 "find /home/esinkirill/backups/* -mtime +7 -exec rm {} \;"
' sh "$now"
echo "Создана и скопирована сжатая резервная копия медиафайлов, а также удалены старые файлы резервных копий на удаленном хосте."

docker exec lmnad_web sh -c 'rm -f /root/backups/*'
echo "Удалены временные файлы резервных копий на контейнере lmnad_web."

=======
mysqldump=/usr/bin/mysqldump
mysql_user=<user>
mysql_password=<pwd>

basedir=/root/backup
backup_dir=files

# Clear current backups
cd $basedir/$backup_dir
rm -f backup*

now=$(date +"%d_%m_%Y")

# Make mysql backup
$mysqldump --user=$mysql_user --password=$mysql_password --triggers --routines --databases lmnad_db | gzip > backup_$now.sql.gz

# Make files backup
tar cvzf backup.lmnad_uploads_$now.tar.gz /var/www/site/lmnad/project/media/

cp -r * /mnt/lmnad2.yandex.disk/backup/
>>>>>>> master

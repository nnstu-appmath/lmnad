#!/bin/bash

read -p "Enter the backup date (in format dd_mm_yyyy): " backup_date

if [ -z "$backup_date" ]; then
    echo "Backup date is not specified."
    exit 1
fi

cd /home/esinkirill/backups

gunzip -k backup_${backup_date}.sql.gz

docker cp /home/esinkirill/backups/backup_${backup_date}.sql lmnad_mysql:/tmp

docker exec -i lmnad_mysql bash -c "mysql --binary-mode=1 -u root -p78910 lmnad_db < /tmp/backup_${backup_date}.sql"

docker cp /home/esinkirill/backups/backup.lmnad_uploads_${backup_date}.tar.gz lmnad_web:/tmp

docker exec -i lmnad_web bash -c "cd /tmp && tar -xvf backup.lmnad_uploads_${backup_date}.tar.gz"

docker exec -i lmnad_web bash -c "cp -r /tmp/uploads/ /lmnad/project/media/ && rm -rf /tmp/uploads && rm -f /tmp/backup.lmnad_uploads_${backup_date}.tar.gz"

docker exec lmnad_mysql bash -c "rm -rf /tmp/backup_${backup_date}.sql"

rm -f /home/esinkirill/backups/backup_${backup_date}.sql


# Cron tab settings

### Actual
```bash
# make backup
27 04 * * * /home/esinkirill/backup.sh >> /home/esinkirill/backup.log 2>&1

# recreate ssl sert
0 0 */15 * * docker run -t --rm -v lmnad_certs:/etc/letsencrypt -v lmnad_certs_data:/data/letsencrypt -v /var/log/letsencrypt:/var/log/letsencrypt deliverous/certbot renew --webroot --webroot-path=/data/letsencrypt && docker kill -s nginx >/dev/null 2>&1
```

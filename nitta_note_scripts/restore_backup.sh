# Restore Backup
db_password=123
site_name=nitta.localhost
db_backup=20230725_000039-nitta_localhost-database.sql.gz
public_file_backup=20230725_000039-nitta_localhost-files.tar
private_file_backup=20230725_000039-nitta_localhost-private-files.tar

cd ../
sudo docker cp nitta_note_scripts/backup/$db_backup $(sudo docker compose ps -q backend):/tmp
sudo docker cp nitta_note_scripts/backup/$private_file_backup $(sudo docker compose ps -q backend):/tmp
sudo docker cp nitta_note_scripts/backup/$public_file_backup $(sudo docker compose ps -q backend):/tmp
sudo docker compose exec backend bench --site $site_name restore --with-public-files /tmp/$public_file_backup --with-private-files /tmp/$private_file_backup /tmp/$db_backup --mariadb-root-password $db_password
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend

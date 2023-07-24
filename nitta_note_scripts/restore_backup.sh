# Restore Backup
db_password=123
site_name=hybrid.localhost
db_backup=20230723_000417-hybrid_localhost-database.sql.gz

cd ../
sudo docker cp nitta_note_scripts/backup/$db_backup $(sudo docker compose ps -q backend):/tmp
sudo docker compose exec backend bench --site $site_name restore /tmp/$db_backup --mariadb-root-password $db_password
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend

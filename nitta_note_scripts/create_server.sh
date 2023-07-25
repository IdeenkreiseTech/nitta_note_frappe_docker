# Create Site and Install Application
db_password=123
admin_password=123
encryption_key=123
git_password=123
site_name=nitta.localhost
cd ../
sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password
sudo docker pull ghcr.io/ideenkreisetech/nitta_note_app/nitta_note_app:1.0.0
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
sudo docker compose exec backend bench new-site $site_name  --no-mariadb-socket --mariadb-root-password $db_password --admin-password $admin_password
sudo docker compose exec backend bench --site $site_name install-app nitta_note_app
sudo docker compose exec backend bench --site $site_name set-config encryption_key $encryption_key
sudo docker compose exec backend bench --site $site_name enable-scheduler

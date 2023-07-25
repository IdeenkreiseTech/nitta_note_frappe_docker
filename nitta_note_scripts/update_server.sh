# Update code in site
git_password=123
site_name=nitta.localhost

cd ../
sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password
sudo docker pull ghcr.io/ideenkreisetech/nitta_note_app/nitta_note_app:1.0.0
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml down
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend

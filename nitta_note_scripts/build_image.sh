git_password=123

cd ../
yes|docker builder prune --all

# Create the JSON string with proper formatting
app1='{"url": "https://IdeenkreiseTech:'"$git_password"'@github.com/IdeenkreiseTech/nitta_note_app.git","branch": "develop"}'
export APPS_JSON='['"$app1"']'
export APPS_JSON_BASE64=$(echo ${APPS_JSON} | base64 -w 0)

docker build \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=v14.32.1 \
  --build-arg=PYTHON_VERSION=3.10.12 \
  --build-arg=NODE_VERSION=16.20.1 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=ghcr.io/ideenkreisetech/nitta_note_app/nitta_note_app:1.0.0 \
  --file=images/custom/Containerfile .

sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password

sudo docker push ghcr.io/ideenkreisetech/nitta_note_app/nitta_note_app:1.0.0

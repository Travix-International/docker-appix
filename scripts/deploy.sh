#!/bin/bash

set -e

APP_CATALOG_URL=${APP_CATALOG_URL:-"https://appcatalog.travix.com"}

function retrieve_app_catalog() {
  curl \
    -s \
    -X GET \
    --header 'Accept: application/json' \
    "${APP_CATALOG_URL}/apps/current/Dev" -o ${1}
}

# get higher version of the current app
retrieve_app_catalog "appcatalog.json"
current_version=$(jq ".[] | if .name == \"$APP_NAME\" then .version else \"\" end" appcatalog.json | tr -d '"' | tr -d '[:space:]')
APP_VERSION=$(echo $current_version | awk '{split($0,a,"."); print a[1] "." a[2] "." a[3]+1}')

# update version in app.manifest
app_manifest=$(jq ".version|=\"${APP_VERSION}\"" app.manifest)

# override the app.manifest
echo $app_manifest > app.manifest

# submit the application after the modification of the `app.manifest`
appix submit . 1>err 2>logs

# check if we have some logs
if [ -e "./logs" ]; then

  # extract the app name and the app id from the output
  url=$(cat ./logs | grep -io "${APP_CATALOG_URL}/apps/current/acc?[a-zA-Z0-9=.&_-]*")

  if [ -n $url ]; then
    # get the parameters from the url
    app_params=$(echo $url | awk -F'[=&]' '{print ($2, $4)}')
    
    app_name=$(echo $app_params | cut -d" " -f1)
    app_version=$(echo $app_params | cut -d" " -f2)

    # get the app cacatalog
    retrieve_app_catalog "appcatalog.json"

    # look for the appId
    app_id=$(jq ".[] | if .name == \"$app_name\" and .version == \"$app_version\" then .id else \"\" end" appcatalog.json | tr -d '"' | tr -d '[:space:]')

    # get idToken
    id_token=$(jq ".Token .id_token" $HOME/.appix/auth.json | tr -d '"')

    # update the status
    http_code=$(curl --header "Content-Length: 0" --header "Authorization: Bearer ${id_token}" -sS -w "%{http_code}" -o /dev/null -X PUT "${APP_CATALOG_URL}/apps/${app_id}/accept")

    if [ $http_code == "200" ]; then
      exit 0
    else
      exit 1
    fi
  else
    exit 1
  fi
else
  exit 1
fi
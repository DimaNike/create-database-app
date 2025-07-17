#!/bin/bash

# Database connection wrapper functions
source ../.env

connect_stage_admin() {
  sql "admin/\"$MLE_APP_ADMIN_STAGE_PASS\"@$MLE_APP_DB_NAME_STAGE?TNS_ADMIN=../terraform/wallet/unzipped" "$@"
}

local_app_connect_string() {
  echo "$MLE_APP_USER_NAME/\"$MLE_APP_USER_PASS\"@localhost:<%= databasePort %>/<%= serviceName %>"
}

connect_local_app() {
  sql "$(local_app_connect_string)" "$@"
}

stage_app_connect_string() {
  echo "$MLE_APP_USER_NAME/\"$MLE_APP_USER_STAGE_PASS\"@$MLE_APP_DB_NAME_STAGE?TNS_ADMIN=../terraform/wallet/unzipped" "$@"
}

connect_stage_app() {
  sql "$MLE_APP_USER_NAME/\"$MLE_APP_USER_STAGE_PASS\"@$MLE_APP_DB_NAME_STAGE?TNS_ADMIN=../terraform/wallet/unzipped" "$@"
}

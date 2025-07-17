#!/bin/bash

# Database connection wrapper functions
source ../.env

connect_stage_admin() {
  sql "admin/\"$MLE_APP_ADMIN_STAGE_PASS\"@devadb_tpurgent?TNS_ADMIN=../terraform/wallet/unzipped" "$@"
}

local_app_connect_string() {
  echo "$MLE_APP_USER_NAME/\"$MLE_APP_USER_PASS\"@localhost:1235/FREEPDB1"
}

connect_local_app() {
  sql "$(local_app_connect_string)" "$@"
}

stage_app_connect_string() {
  echo "$MLE_APP_USER_NAME/\"$MLE_APP_USER_STAGE_PASS\"@devadb_tpurgent?TNS_ADMIN=../terraform/wallet/unzipped"
}

connect_stage_app() {
  sql $(stage_app_connect_string) "$@"
}

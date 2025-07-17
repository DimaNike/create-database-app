#!/bin/bash
# Script to deploy DB migrations and sync ORDS endpoints for local development Oracle DB Free

set -euo pipefail

pushd "$(dirname "${BASH_SOURCE[0]}")"

source ./db_connect.sh
# Ensure required environment variables are set
: "${MLE_APP_USER_NAME:?You must set MLE_APP_USER_NAME}"
: "${MLE_APP_USER_PASS:?You must set MLE_APP_USER_PASS}"

echo "Starting Liquibase migrations for local DB user $MLE_APP_USER_NAME..."
connect_local_app << EOF
  lb update -changelog-file=migrations.json
EOF
echo "Migrations completed."

echo "Synchronizing ORDS endpoints from src/routes with mle-cliw..."
mle-cli --experimental build -c '<%= connectionUsername %>/<%= connectionPassword %>@localhost:<%= databasePort %>/<%= serviceName %>' create ords-fs
echo "ORDS API configuration completed."

popd

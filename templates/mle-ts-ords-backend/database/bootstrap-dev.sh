#!/bin/bash

set -x
pushd "$(dirname "${BASH_SOURCE[0]}")"

# note this script is invoked from the db_bootstrapper compose service
connect_sys_dev() {
  sql "sys/oracle@localhost:<%= databasePort %>/<%= serviceName %> as sysdba" "$@"
}

connect_sys_dev_cdb() {
  sql "sys/oracle@localhost:<%= databasePort %> as sysdba" "$@"
}

connect_sys_dev_cdb << EOF
  ALTER SYSTEM SET pga_aggregate_limit = 0;
EOF

connect_sys_dev @./user-setup.sql <%= connectionUsername %> <%= connectionPassword %>

popd

#!/bin/bash

set -e

mlock_setting="true"
if [ "$DISABLE_MLOCK" = "false" ]; then
  mlock_setting="false"
fi

ui_setting="false"
if [ "$UI" = "true" ]; then
  ui_setting="true"
fi

tls_setting="true"
if [ "$TLS_DISABLE" = "false" ]; then
  tls_setting="false"
fi

cat << EOF
ui = ${ui_setting}
disable_mlock = ${mlock_setting}

storage "postgresql" {
  connection_url = "${DATABASE_URL:?}"
}

listener "tcp" {
 address = "127.0.0.1:8080"
 tls_disable = ${tls_setting}
}
EOF

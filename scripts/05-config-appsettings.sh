#!/usr/bin/env bash
set -euo pipefail

SQL_CONN_JDBC="jdbc:sqlserver://$SQL_SERVER.database.windows.net:1433;database=$SQL_DB;encrypt=true;trustServerCertificate=false;loginTimeout=30;"

az webapp config appsettings set \
  -g "$RG" -n "$WEBAPP" --settings \
  SPRING_DATASOURCE_URL="$SQL_CONN_JDBC" \
  SPRING_DATASOURCE_USERNAME="$SQL_ADMIN_USER" \
  SPRING_DATASOURCE_PASSWORD="$SQL_ADMIN_PASS" \
  SPRING_JPA_HIBERNATE_DDL_AUTO=update \
  JAVA_OPTS="-Dserver.port=8080"


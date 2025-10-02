#!/usr/bin/env bash
set -euo pipefail

az sql server create \
  -g "$RG" -n "$SQL_SERVER" \
  -l "$LOCATION" \
  -u "$SQL_ADMIN_USER" -p "$SQL_ADMIN_PASS"

az sql server firewall-rule create \
  -g "$RG" -s "$SQL_SERVER" \
  -n AllowAzureServices \
  --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

az sql db create \
  -g "$RG" -s "$SQL_SERVER" \
  -n "$SQL_DB" --service-objective S0

az sql db show -g "$RG" -s "$SQL_SERVER" -n "$SQL_DB" --query status -o tsv

echo "JDBC:"
echo "jdbc:sqlserver://$SQL_SERVER.database.windows.net:1433;database=$SQL_DB;encrypt=true;trustServerCertificate=false;loginTimeout=30;"


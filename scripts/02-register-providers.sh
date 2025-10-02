#!/usr/bin/env bash
set -euo pipefail

az group create -n "$RG" -l "$LOCATION"

az provider register -n Microsoft.Sql  >/dev/null
az provider register -n Microsoft.Web >/dev/null

echo "Microsoft.Sql   -> $(az provider show -n Microsoft.Sql  --query registrationState -o tsv)"
echo "Microsoft.Web   -> $(az provider show -n Microsoft.Web  --query registrationState -o tsv)"


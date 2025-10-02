#!/usr/bin/env bash
set -euo pipefail

az webapp log config -g "$RG" -n "$WEBAPP" --application-logging filesystem --level information

HOST="$(az webapp show -g "$RG" -n "$WEBAPP" --query defaultHostName -o tsv)"
echo "Swagger: https://$HOST/swagger-ui/index.html"

az webapp log tail -g "$RG" -n "$WEBAPP"


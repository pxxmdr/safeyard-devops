#!/usr/bin/env bash
set -euo pipefail

az appservice plan create \
  -g "$RG" -n "$PLAN" --sku B1 --is-linux

az webapp create \
  -g "$RG" -p "$PLAN" \
  -n "$WEBAPP" \
  --runtime "JAVA:17-java17"

az webapp show -g "$RG" -n "$WEBAPP" --query defaultHostName -o tsv


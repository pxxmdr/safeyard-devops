#!/usr/bin/env bash
set -euo pipefail

az webapp config appsettings set \
  -g "$RG" -n "$WEBAPP" --settings SPRING_JPA_HIBERNATE_DDL_AUTO=none

az webapp restart -g "$RG" -n "$WEBAPP"


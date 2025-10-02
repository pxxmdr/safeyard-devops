#!/usr/bin/env bash
set -euo pipefail

echo "Isso vai apagar TODO o grupo $RG. Ctrl+C para cancelar."
az group delete -n "$RG" --yes --no-wait


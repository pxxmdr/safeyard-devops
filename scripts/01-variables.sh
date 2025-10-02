#!/usr/bin/env bash
set -euo pipefail

# >>>>> EDITE APENAS A SENHA <<<<<
export LOCATION="brazilsouth"
export RG="rg-safeyard"

export RAND="$(openssl rand -hex 2)"

export SQL_SERVER="sql-safeyard-$RAND"
export SQL_ADMIN_USER="sqladmin"
export SQL_ADMIN_PASS="PLACEHOLDER#TroqueAqui"   # <<<<< troque no Cloud Shell
export SQL_DB="db-safeyard"

export PLAN="plan-safeyard"
export WEBAPP="app-safeyard-$RAND"

echo "Variáveis definidas:"
echo "RG=$RG | LOCATION=$LOCATION | RAND=$RAND"
echo "SQL_SERVER=$SQL_SERVER | SQL_DB=$SQL_DB"
echo "WEBAPP=$WEBAPP | PLAN=$PLAN"

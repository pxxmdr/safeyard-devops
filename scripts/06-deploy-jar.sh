#!/usr/bin/env bash
set -euo pipefail

test -f "$HOME/safeyard.jar" || { echo "Suba ~/safeyard.jar antes."; exit 1; }

# comando de inicialização (Java SE)
az webapp config set -g "$RG" -n "$WEBAPP" --startup-file "java -jar /home/site/wwwroot/*.jar"

# deploy
az webapp deploy -g "$RG" -n "$WEBAPP" --src-path "$HOME/safeyard.jar" --type jar

# garantir profile/porta
az webapp config appsettings set -g "$RG" -n "$WEBAPP" --settings SPRING_PROFILES_ACTIVE=prod JAVA_OPTS="-Dserver.port=8080"

az webapp restart -g "$RG" -n "$WEBAPP"


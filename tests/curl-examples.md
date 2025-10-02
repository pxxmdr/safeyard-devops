# Testes rápidos (curl)
HOST="https://app-safeyard-XXXX.azurewebsites.net"

# 1) Obtenha o token JWT com suas credenciais (ajuste a rota do seu login)
TOKEN="$(curl -s -X POST "$HOST/api/auth/login" -H "Content-Type: application/json" \
  -d '{"email":"admin@safeyard.com","password":"SUA_SENHA"}' | jq -r '.token')"

# 2) Cria moto
curl -i -X POST "$HOST/api/motos" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
  -d '{"placa":"ABC1D23","modelo":"CG 160","ano":2023}'


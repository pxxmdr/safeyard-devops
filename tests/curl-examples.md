# ===== Config =====
HOST="https://app-safeyard-XXXX.azurewebsites.net"   # ajuste seu host
LOGIN="admin@safeyard.com"                           # seu usuário
SENHA="SUA_SENHA"                                    # sua senha

# ===== 1) Obter token JWT =====
TOKEN="$(curl -sS -X POST "$HOST/api/auth/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$LOGIN\",\"password\":\"$SENHA\"}" | jq -r '.token')"

echo "TOKEN=$TOKEN"
if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo "Falha ao obter token. Verifique a rota/payload e se o usuário é ADMIN."
  exit 1
fi

# ===== 2) Criar moto =====
ID="$(curl -sS -X POST "$HOST/api/motos" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"placa":"ABC1D23","modelo":"CG 160","ano":2023}' | jq -r '.id')"

echo "ID criado: $ID"

# ===== 3) Listar motos =====
curl -sS "$HOST/api/motos" -H "Authorization: Bearer $TOKEN" | jq

# ===== 4) Buscar por ID =====
curl -sS "$HOST/api/motos/$ID" -H "Authorization: Bearer $TOKEN" | jq

# ===== 5) Atualizar =====
curl -i -X PUT "$HOST/api/motos/$ID" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"placa":"ABC1D23","modelo":"CG 160 Start","ano":2024}'

# ===== 6) Excluir =====
curl -i -X DELETE "$HOST/api/motos/$ID" -H "Authorization: Bearer $TOKEN"

#!/bin/bash
# Teste local do keep-alive — roda no seu computador para validar antes de subir ao GitHub.
# Uso: bash testar-ping.sh

SUPABASE_URL="https://iraddjftufipfugcymly.supabase.co"
SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlyYWRkamZ0dWZpcGZ1Z2N5bWx5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk3MzQ3MDQsImV4cCI6MjA5NTMxMDcwNH0.PZ3LwZr4j2OBz_RgRYjO0z6jyr_RtLLhYEHlG5zOLzs"

echo "Testando ping no Supabase..."

RESPONSE=$(curl -s -w "\n%{http_code}" -X PATCH \
  "${SUPABASE_URL}/rest/v1/keepalive?id=eq.1" \
  -H "apikey: ${SUPABASE_ANON_KEY}" \
  -H "Authorization: Bearer ${SUPABASE_ANON_KEY}" \
  -H "Content-Type: application/json" \
  -H "Prefer: return=representation" \
  -d "{\"last_ping\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

echo "Status HTTP: $HTTP_CODE"
echo "Resposta: $BODY"

if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 300 ]; then
  echo "✓ Funcionou! O Supabase respondeu corretamente."
else
  echo "✗ Algo deu errado (HTTP $HTTP_CODE)."
fi

#!/bin/bash
# Script de build do Cloudflare Pages.
# Substitui APENAS a linha da constante GEMINI_KEY pela variavel de ambiente,
# sem afetar as comparacoes logicas no resto do codigo.
# A variavel GEMINI_KEY e configurada no painel do Cloudflare (nunca no GitHub).

set -e

if [ -z "$GEMINI_KEY" ]; then
  echo "AVISO: variavel GEMINI_KEY nao definida. App publicado sem chave Gemini."
  echo "Configure em: Cloudflare Pages > Settings > Environment variables"
else
  echo "Injetando chave Gemini na constante..."
  # Substitui SOMENTE a linha que define a constante (linha que comeca com 'const GEMINI_KEY =')
  sed -i "s|^const GEMINI_KEY = \"SUA_CHAVE_GEMINI_AQUI\";|const GEMINI_KEY = \"${GEMINI_KEY}\";|" index.html
  echo "Chave injetada com sucesso na constante GEMINI_KEY."
fi

echo "Build concluido."

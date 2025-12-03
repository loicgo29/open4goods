#!/usr/bin/env bash
set -euo pipefail

INPUT="${1:-env.yaml}"  
OUTPUT="../../frontend/.env"

# Déchiffrer si fichier chiffré
if [[ "$INPUT" == *.sops.yaml ]]; then
  echo "🔓 Déchiffrement SOPS…"
  TMP=$(mktemp)
  sops -d "$INPUT" > "$TMP"
  INPUT="$TMP"
fi

echo "📝 Génération de $OUTPUT"

cat <<EOF > "$OUTPUT"
NUXT_PUBLIC_API_URL=$(yq -r '.NUXT_PUBLIC_API_URL' "$INPUT")
NUXT_MACHINE_TOKEN=$(yq -r '.NUXT_MACHINE_TOKEN' "$INPUT")
NUXT_PUBLIC_HCAPTCHA_SITE_KEY=$(yq -r '.NUXT_PUBLIC_HCAPTCHA_SITE_KEY' "$INPUT")
NUXT_PUBLIC_EDITOR_ROLES=$(yq -r '.NUXT_PUBLIC_EDITOR_ROLES' "$INPUT")
NUXT_APP_ENV=$(yq -r '.NUXT_APP_ENV' "$INPUT")
EOF

echo "✔ Fichier généré : $OUTPUT"

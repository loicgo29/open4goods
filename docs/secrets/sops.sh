#!/usr/bin/env bash
set -euo pipefail

# on force la clé AGE pour sops
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"

ACTION="${1:-}"
FILE="${2:-}"

if [[ -z "$ACTION" || -z "$FILE" ]]; then
  echo "Usage: $0 <encrypt|decrypt> <file>"
  exit 1
fi

case "$ACTION" in
  encrypt)
    OUT="${FILE%.yaml}.sops.yaml"
    echo "🔐 Chiffrement → $OUT"
    sops -e "$FILE" > "$OUT"
    echo "✔ Fichier chiffré : $OUT"
    ;;

  decrypt)
    OUT="${FILE%.sops.yaml}.yaml"
    echo "🔓 Déchiffrement → $OUT"
    sops -d "$FILE" > "$OUT"
    echo "✔ Fichier déchiffré : $OUT"
    ;;

  *)
    echo "Action inconnue : $ACTION"
    echo "Usage: $0 <encrypt|decrypt> <file>"
    exit 1
    ;;
esac

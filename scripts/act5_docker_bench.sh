#!/usr/bin/env bash
# Actividad 5 — Docker Bench for Security (SOLO LECTURA)
set -euo pipefail

OUT_DIR="${1:-$HOME/auditoria-sprint1/docker_bench}"
REPO_DIR="$HOME/docker-bench-security"
OUT_FILE="$OUT_DIR/docker_bench_antes.txt"

mkdir -p "$OUT_DIR"

echo "=== ACT 5 — DOCKER BENCH (baseline ANTES) ==="

if [[ ! -d "$REPO_DIR" ]]; then
  git clone https://github.com/docker/docker-bench-security.git "$REPO_DIR"
fi

cd "$REPO_DIR"
git pull --quiet 2>/dev/null || true

echo "Ejecutando Docker Bench (puede tardar 5-10 min)..."
sudo sh docker-bench-security.sh 2>&1 | tee "$OUT_FILE"

echo ""
echo "=== Resumen PASS / WARN / INFO / NOTE ==="
grep -cE '\[PASS\]' "$OUT_FILE" | xargs -I{} echo "PASS: {}" || true
grep -cE '\[WARN\]' "$OUT_FILE" | xargs -I{} echo "WARN: {}" || true
grep -cE '\[INFO\]' "$OUT_FILE" | xargs -I{} echo "INFO: {}" || true

echo "Salida completa: $OUT_FILE"

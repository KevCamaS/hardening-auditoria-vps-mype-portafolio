#!/usr/bin/env bash
# Actividad 4 — Escaneo Nmap (SOLO LECTURA)
set -euo pipefail

OUT_DIR="${1:-$HOME/auditoria-sprint1/nmap}"
mkdir -p "$OUT_DIR"

echo "=== ACT 4 — NMAP (baseline ANTES) ==="
echo "Directorio salida: $OUT_DIR"

sudo apt-get install -y nmap >/dev/null 2>&1 || true

echo "[1/3] TCP top 1000 puertos (localhost)..."
nmap -sT --top-ports 1000 -T4 127.0.0.1 -oN "$OUT_DIR/nmap_local_top1000.txt" -oX "$OUT_DIR/nmap_local_top1000.xml"

echo "[2/3] TCP full scan (localhost) — puede tardar varios minutos..."
nmap -sT -p- -T4 127.0.0.1 -oN "$OUT_DIR/nmap_local_full_tcp.txt" -oX "$OUT_DIR/nmap_local_full_tcp.xml"

echo "[3/3] UDP top 100 (localhost)..."
sudo nmap -sU --top-ports 100 -T4 127.0.0.1 -oN "$OUT_DIR/nmap_udp_top100.txt" -oX "$OUT_DIR/nmap_udp_top100.xml"

echo "=== Resumen puertos abiertos TCP (full) ==="
grep -E "^[0-9]+/tcp.*open" "$OUT_DIR/nmap_local_full_tcp.txt" || true

echo "Salidas en: $OUT_DIR"

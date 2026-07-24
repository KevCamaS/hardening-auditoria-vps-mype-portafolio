#!/usr/bin/env bash
# Actividad 1 — Reconocimiento inicial (SOLO LECTURA)
# Ejecutar en la VPS como usuario mype. No modifica configuración.
set -euo pipefail

OUT="${1:-./act1_reconocimiento.txt}"
{
  echo "=== ACTIVIDAD 1 — RECONOCIMIENTO INICIAL ==="
  echo "Fecha (UTC): $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
  echo "Fecha (local VPS): $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo ""

  echo "--- 1. Identidad de sesión ---"
  whoami
  id
  echo "Hostname: $(hostname -f 2>/dev/null || hostname)"
  echo ""

  echo "--- 2. Sistema operativo ---"
  hostnamectl 2>/dev/null || true
  lsb_release -a 2>/dev/null || cat /etc/os-release
  echo "Kernel: $(uname -r)"
  echo ""

  echo "--- 3. Uptime y carga ---"
  uptime
  echo ""

  echo "--- 4. Recursos (CPU/RAM/disco) ---"
  nproc
  free -h
  df -hT
  echo ""

  echo "--- 5. Tailscale ---"
  if command -v tailscale >/dev/null 2>&1; then
    tailscale status 2>/dev/null || echo "tailscale status requiere permisos"
    tailscale ip -4 2>/dev/null || true
  else
    echo "tailscale CLI no instalada"
  fi
  echo ""

  echo "--- 6. Sudo (solo consulta) ---"
  sudo -n true 2>/dev/null && echo "sudo: disponible sin password (NOPASSWD)" || echo "sudo: requiere password o no disponible"
  sudo -l 2>/dev/null | head -20 || true
  echo ""

  echo "--- 7. Docker (solo presencia) ---"
  docker --version 2>/dev/null || echo "docker no encontrado"
  docker compose version 2>/dev/null || docker-compose --version 2>/dev/null || true
  echo ""

  echo "--- 8. Servicios systemd activos (muestra) ---"
  systemctl list-units --type=service --state=running --no-pager 2>/dev/null | head -25 || true
  echo ""

  echo "--- 9. Usuarios con shell de login ---"
  getent passwd | awk -F: '$7 !~ /(nologin|false)$/ {print $1, $6, $7}' || true
  echo ""

  echo "=== FIN ACTIVIDAD 1 ==="
} | tee "$OUT"

echo "Salida guardada en: $OUT"

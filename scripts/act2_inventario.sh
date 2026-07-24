#!/usr/bin/env bash
# Actividad 2 — Inventario servicios, puertos, Docker (SOLO LECTURA)
set -euo pipefail

OUT="${1:-./act2_inventario_servicios.txt}"
{
  echo "=== ACTIVIDAD 2 — INVENTARIO DE SERVICIOS ==="
  echo "Fecha (UTC): $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
  echo ""

  echo "--- 1. Puertos en escucha (TCP/UDP) ---"
  ss -tulpn 2>/dev/null || sudo ss -tulpn
  echo ""

  echo "--- 2. Procesos escuchando (top 30) ---"
  sudo ss -tulpn 2>/dev/null | tail -n +2 | head -30 || true
  echo ""

  echo "--- 3. Docker — contenedores ---"
  docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' 2>/dev/null || echo "sin acceso docker"
  echo ""

  echo "--- 4. Docker — imágenes ---"
  docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}' 2>/dev/null | head -40 || true
  echo ""

  echo "--- 5. Docker — redes ---"
  docker network ls 2>/dev/null || true
  docker network inspect bridge --format '{{json .IPAM}}' 2>/dev/null || true
  echo ""

  echo "--- 6. Docker — volúmenes ---"
  docker volume ls 2>/dev/null || true
  echo ""

  echo "--- 7. Compose files (sin leer secretos) ---"
  sudo find /home /opt /var/www /srv -maxdepth 5 \
    \( -name 'docker-compose.yml' -o -name 'docker-compose.yaml' -o -name 'compose.yml' -o -name 'compose.yaml' \) \
    2>/dev/null | head -30 || true
  echo ""

  echo "--- 8. Archivos .env (rutas y permisos, NO contenido) ---"
  sudo find /home /opt /var/www /srv -maxdepth 6 -name '.env' -o -name '.env.*' 2>/dev/null \
    | while read -r f; do sudo ls -la "$f" 2>/dev/null; done | head -40 || true
  echo ""

  echo "--- 9. Contenedores — usuario (root vs no-root) ---"
  for c in $(docker ps -q 2>/dev/null); do
    name=$(docker inspect --format '{{.Name}}' "$c" | tr -d '/')
    user=$(docker inspect --format '{{.Config.User}}' "$c")
    echo "$name -> User config: '${user:-<default/root>}'"
  done
  echo ""

  echo "--- 10. iptables/nft (solo listado) ---"
  sudo ufw status verbose 2>/dev/null || echo "ufw no activo o no instalado"
  echo ""

  echo "=== FIN ACTIVIDAD 2 ==="
} | tee "$OUT"

echo "Salida guardada en: $OUT"

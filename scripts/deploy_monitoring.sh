#!/usr/bin/env bash
# Despliegue del stack de monitoreo EN LA VPS
# Ejecutar después de Act. 1-2. Requiere sudo para Nginx/certbot.
set -euo pipefail

MON_DIR="${MON_DIR:-/opt/monitoring}"

echo "==> Creando directorio $MON_DIR"
sudo mkdir -p "$MON_DIR"
sudo chown "$USER:$USER" "$MON_DIR"

echo "==> Copia manual requerida: sube el contenido de 03_monitoreo/ a $MON_DIR"
echo "    Desde tu PC (PowerShell en D:/):"
echo "    scp -r D:/hardening-auditoria-vps-mype-2026/03_monitoreo/* mype@<TAILSCALE_IP>:$MON_DIR/"

if [[ ! -f "$MON_DIR/.env" ]]; then
  echo "ERROR: crea $MON_DIR/.env desde .env.example con password seguro"
  exit 1
fi

cd "$MON_DIR"
docker compose pull
docker compose up -d
docker compose ps

echo "==> Verificar targets Prometheus: http://127.0.0.1:9090/targets (vía SSH tunnel)"
echo "==> Grafana local: http://127.0.0.1:3000 (vía Nginx después)"

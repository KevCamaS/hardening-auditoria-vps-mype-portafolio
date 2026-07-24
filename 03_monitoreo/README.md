# Módulo 03 — Monitoreo en tiempo real

**Contexto:** este stack se despliega **en paralelo** a la fase de endurecimiento de la VPS. La auditoría profunda (Lynis, Nmap, Docker Bench) y el hardening (Act. 9–14) continúan en el siguiente sprint.

## Arquitectura

```
Internet / Tailscale
        │
        ▼
   Nginx (reverse proxy + allow/deny IP)
        │
        ├── /grafana/ → Grafana :3000 (127.0.0.1)
        │
Prometheus :9090 ← scrape ← Node Exporter :9100
        (red Docker interna)
```

## Roles Grafana

| Usuario | Rol | Alcance |
|---|---|---|
| Admin (jefe) | Grafana Admin | Todo: dashboards, datasources, hallazgos futuros de seguridad |
| Colaborador | Viewer + permiso de carpeta | Solo carpeta **Operaciones** (métricas de su app) |

## Despliegue en VPS

Ver comandos en la guía de ejecución del chat / `scripts/deploy_monitoring.sh`.

## Impacto en laptop de desarrollo

El stack corre **100% en la VPS**. El laptop solo usa SSH y edita archivos en `D:/`. No instalar Docker Desktop en Windows con disco C: limitado.

## Pendiente siguiente sprint

- Dashboards por contenedor (cAdvisor)
- Alertmanager + notificaciones
- Integración Wazuh (Act. 15)
- HTTPS definitivo si DNS no estuvo listo en ventana de 3h

# Actividad 4 — Nmap (baseline ANTES)

Escaneo contra `127.0.0.1` (vista local del host). Complementar con Act. 2 (`ss -tulpn`) para distinguir `0.0.0.0` vs `127.0.0.1`.

## Puertos TCP abiertos detectados (16)

| Puerto | Servicio Nmap | Exposición probable | Notas |
|---|---|---|---|
| 22 | ssh | Público (0.0.0.0) | Esperado; hardening Act. 10 |
| 80 | http | Público | Nginx |
| 443 | https | Público | Nginx |
| 1005 | unknown | Público (0.0.0.0) | new_page_mype-web |
| 2368 | opentable | Solo localhost | Ghost blog |
| 3000 | ppp | Localhost | Grafana (monitoreo) |
| 3003 | cgms | Público | webhook-shopimax |
| 3306 | mysql | Solo localhost | MySQL — OK local, verificar UFW |
| 3334 | directv-web | Público | chat-nube-backend |
| 3335 | directv-soft | Público | chat-nube-frontend |
| 4000 | remoteanything | Público | api-shopimax |
| 4687 | nst | Solo localhost | app-flow-frontend |
| 4688 | mobile-p2p | Solo localhost | app-flow-backend |
| 9090 | zeus-admin | Localhost | Prometheus |
| 9100 | jetdirect | Localhost | Node Exporter |
| 33060 | mysqlx | Solo localhost | MySQL X Protocol |

## Hallazgos para Act. 8 (plan remediación)

- **Exposición pública innecesaria:** 3334, 3335, 4000, 3003, 1005 (apps Docker en 0.0.0.0) — candidatos a bind 127.0.0.1 + Nginx reverse proxy en Act. 11/13.
- **MySQL 3306:** escucha solo en 127.0.0.1 — hallazgo positivo vs exposición pública.
- **Monitoreo 3000/9090/9100:** correctamente en localhost.

## Archivos

- `nmap_local_top1000.txt`
- `nmap_local_full_tcp.txt`
- `nmap_udp_top100.txt`

## Captura

- `evidencias/sprint0/S1_Act4_nmap_puertos_expuestos.png`

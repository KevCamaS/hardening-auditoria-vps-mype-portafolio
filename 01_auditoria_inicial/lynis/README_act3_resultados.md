# Actividad 3 — Lynis (baseline ANTES)

## Métricas capturadas

| Métrica | Valor | Interpretación |
|---|---|---|
| **Hardening Index** | **65 / 100** | Nivel medio-bajo; margen claro de mejora post-hardening (meta ≥ 80) |
| **Tests performed** | 265 | Lynis ejecutó 265 comprobaciones individuales |
| **Plugins enabled** | 1 | Un módulo plugin activo (escaneo estándar + plugin del perfil default) |
| **Warnings** | 3 | Hallazgos que requieren atención prioritaria |
| **Suggestions** | 56 | Recomendaciones de endurecimiento pendientes |

## Componentes detectados

- **Firewall:** detectado (UFW activo)
- **Malware scanner:** no instalado

## Warnings principales (antes del hardening)

1. Paquetes vulnerables desactualizados (`PKGS-7392`)
2. Nameserver Tailscale IPv6 no responde al test (`NETW-2704`) — esperable en entorno overlay
3. Menos de 2 nameservers responsivos (`NETW-2705`)

## Archivos de evidencia

- `lynis_audit_antes.txt` — salida completa de terminal
- `lynis-report_antes.dat` — reporte estructurado Lynis
- `lynis_antes.log` — log detallado

## Capturas

- `evidencias/sprint0/S1_Act3_lynis_ejecucion.png`
- `evidencias/sprint0/S1_Act3_lynis_hardening_index.png`

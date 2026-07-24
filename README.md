# Hardening y auditoría de seguridad — VPS dockerizada MYPE

Portfolio público de un caso aplicado: **auditoría**, **hardening** y **monitoreo** en una VPS Ubuntu 22.04 con Docker. La organización se referencia como **la MYPE** (anonimizada).

## Resultados (pre-test → post-test)

| Indicador | Antes | Después |
|---|---:|---:|
| Lynis Hardening Index | 65/100 | 66/100 (corrida reducida) |
| Archivos `.env` world-readable | 32 | 0 |
| Fail2Ban / auditd | No activos | Activos |
| Puertos Docker en 0.0.0.0 | Expuestos | Mitigados (UFW) |
| Monitoreo centralizado | No | Prometheus + Grafana |

## Estructura

```
01_auditoria_inicial/   Lynis, Nmap, Docker Bench, matriz CIS/NIST
02_hardening/           Evidencias hardening (Act. 9+)
03_monitoreo/           Prometheus / Grafana / Node Exporter
05_documentacion/       Guías
06_paper/               Resumen del artículo científico (Markdown)
scripts/                Scripts reproducibles
evidencias/             Capturas sprint1–sprint7
```

## Metodología

1. Auditoría solo lectura (Lynis, Nmap, Docker Bench, permisos `.env`)
2. Matriz CIS/NIST CSF (V-01…V-10)
3. Hardening controlado con snapshot (SSH, UFW, Fail2Ban, auditd, Docker)
4. Monitoreo y validación post-intervención

## Confidencialidad

Este repositorio es una versión **anonimizada** para portfolio. No incluye datos identificables de la organización, dominios reales ni secretos.

## Regenerar esta copia desde el repo privado

```powershell
python 06_paper/build_public_portfolio.py --out ..\hardening-auditoria-vps-mype-portfolio
```

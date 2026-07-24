# Actividad 5 — Docker Bench for Security (baseline ANTES)

Herramienta: [docker-bench-security](https://github.com/docker/docker-bench-security) (CIS Docker Benchmark).

## Métricas capturadas

| Métrica | Valor | Interpretación |
|---|---|---|
| **Checks totales** | 117 | Controles CIS evaluados |
| **Score** | **5** | Muy bajo — amplio margen de mejora post-hardening (Act. 13) |
| **PASS** | 46 | Controles cumplidos |
| **WARN** | 145 | Advertencias de seguridad pendientes |
| **INFO** | 74 | Informativos / contexto |

## Hallazgos esperados (coherentes con Act. 2)

- Contenedores ejecutándose como **root**
- Configuración del daemon Docker no endurecida
- Imágenes sin escaneo previo (Trivy pendiente Act. 14)
- Redes y volúmenes sin restricciones estrictas

## Archivo de evidencia

- `docker_bench_antes.txt`

## Captura

- `evidencias/sprint0/S2_Act5_docker_bench_resumen.png`

## Meta post-hardening (Act. 17)

Reducción sustancial de WARN → PASS; score CIS Docker mejorado.

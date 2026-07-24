# Actividad 6 — Matriz de vulnerabilidades CIS / NIST (baseline ANTES)

> Lynis (Act. 3), Nmap (Act. 4), Docker Bench (Act. 5) e inventario (Act. 2).


| ID   | Fuente       | Hallazgo                                                  | CIS / NIST CSF     | Severidad | Evidencia               | Remediación (Act.) |
| ---- | ------------ | --------------------------------------------------------- | ------------------ | --------- | ----------------------- | ------------------ |
| V-01 | Lynis        | Hardening Index 65/100                                    | CIS L1 / PR.IP     | Medio     | lynis_audit_antes.txt   | Act. 9             |
| V-02 | Lynis        | Paquetes vulnerables desactualizados                      | CIS L1 / ID.RA     | Alto      | PKGS-7392               | Act. 9             |
| V-03 | Lynis        | Sin Fail2Ban                                              | CIS / DE.CM        | Medio     | DEB-0880                | Act. 12            |
| V-04 | Lynis        | SSH permisivo (MaxAuthTries, PermitRootLogin)             | CIS L1 / PR.AC     | Alto      | SSH-7408                | Act. 10            |
| V-05 | Lynis        | Sin auditd / HIDS                                         | NIST DE.AE         | Medio     | ACCT-9628               | Act. 15            |
| V-06 | Nmap         | Puertos apps Docker en 0.0.0.0 (3334,3335,4000,3003,1005) | CIS / PR.PT        | Alto      | nmap_local_full_tcp.txt | Act. 11, 13        |
| V-07 | Nmap         | SSH 22 expuesto globalmente                               | CIS L1 / PR.PT     | Medio     | nmap + ss               | Act. 10, 11        |
| V-08 | Docker Bench | Score 5/117 — 145 WARN                                    | CIS Docker 1.6     | Alto      | docker_bench_antes.txt  | Act. 13            |
| V-09 | Inventario   | Contenedores en root (6+ activos)                         | CIS Docker / PR.DS | Alto      | act2_inventario         | Act. 13            |
| V-10 | Inventario   | 32 archivos .env con permisos world-readable (664/644)    | NIST PR.DS         | Alto      | act2 compose_env        | Act. 7, 13         |




## Conteo por severidad


| Severidad | Cantidad |
| --------- | -------- |
| Crítico   | 0        |
| Alto      | 6        |
| Medio     | 3        |
| Bajo      | 0        |




## Notas para el paper

- Matriz consolida hallazgos **sin interpretación** (sección Resultados).
- Plan de remediación priorizado alimenta Act. 8 e intervención Act. 9–14.


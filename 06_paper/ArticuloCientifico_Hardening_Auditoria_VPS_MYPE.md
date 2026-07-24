# Implementación de una línea base reproducible de auditoría, hardening y monitoreo para una VPS Ubuntu dockerizada en una MYPE

*Implementation of a reproducible baseline for auditing, hardening, and monitoring of a Dockerized Ubuntu VPS in an MSE*

Cama Sánchez, Kevin Anthony

ORCID (autor de contacto): 0000-0001-9657-7581

Documento de entrega: `ArticuloCientifico_Hardening_Auditoria_VPS_MYPE.docx`

Incluye 15 figuras de evidencia, Tabla 3 (matriz CIS/NIST) y Tabla 4 (remediación).

## Tabla 3. Matriz de vulnerabilidades (línea base)

| ID | Fuente | Hallazgo | CIS/NIST | Severidad | Remediación |
| --- | --- | --- | --- | --- | --- |
| V-01 | Lynis | Hardening Index 65/100 | CIS L1 / PR.IP | Medio | Act. 9 |
| V-02 | Lynis | Paquetes vulnerables desactualizados | CIS L1 / ID.RA | Alto | Act. 9 |
| V-03 | Lynis | Sin Fail2Ban | CIS / DE.CM | Medio | Act. 12 |
| V-04 | Lynis | SSH permisivo (MaxAuthTries, PermitRootLogin) | CIS L1 / PR.AC | Alto | Act. 10 |
| V-05 | Lynis | Sin auditd / HIDS | NIST DE.AE | Medio | Act. 15 |
| V-06 | Nmap | Puertos apps Docker en 0.0.0.0 (3334,3335,4000,3003,1005) | CIS / PR.PT | Alto | Act. 11, 13 |
| V-07 | Nmap | SSH 22 expuesto globalmente | CIS L1 / PR.PT | Medio | Act. 10, 11 |
| V-08 | Docker Bench | Score 5/117 — 145 WARN | CIS Docker 1.6 | Alto | Act. 13 |
| V-09 | Inventario | Contenedores en root (6+ activos) | CIS Docker / PR.DS | Alto | Act. 13 |
| V-10 | Inventario | 32 archivos .env world-readable (664/644) | NIST PR.DS | Alto | Act. 7, 13 |

## Tabla 4. Remediación post-intervención

| ID | Hallazgo | Severidad | Acción | Estado |
| --- | --- | --- | --- | --- |
| V-01 | Hardening Index 65/100 | Medio | apt upgrade, sysctl, banners, login.defs | Mejora limitada (66/100 corrida reducida) |
| V-02 | Paquetes vulnerables | Alto | Actualización de paquetes del SO | Corregido |
| V-03 | Sin Fail2Ban | Medio | Jail sshd + servicio active | Corregido |
| V-04 | SSH permisivo | Alto | Drop-in hardening sshd | Corregido |
| V-05 | Sin auditd / HIDS | Medio | Servicio auditd + reglas activas | Corregido parcial |
| V-06 | Puertos Docker 0.0.0.0 | Alto | Reglas UFW deny puertos directos | Mitigado |
| V-07 | SSH 22 expuesto globalmente | Medio | Hardening SSH + UFW | Parcial (whitelist pendiente) |
| V-08 | Docker Bench score 5 | Alto | pids-limit, permisos, controles host | Parcial |
| V-09 | Contenedores root | Alto | pids-limit + mitigaciones runtime | Parcial |
| V-10 | 32 .env world-readable | Alto | chmod o-rwx (32→0) | Corregido |

## Figuras de evidencia

- Figura 1. Ejecución de auditoría Lynis 3.0.7 sobre la VPS.
- Figura 2. Hardening Index inicial: 65/100 (265 pruebas, 3 warnings, 56 suggestions).
- Figura 3. Inventario de 16 puertos TCP abiertos detectados con Nmap.
- Figura 4. Resumen Docker Bench for Security: score 5, 46 PASS, 145 WARN.
- Figura 5. Revisión de permisos .env en línea base: 32 archivos world-readable.
- Figura 6. Matriz de vulnerabilidades CIS/NIST CSF consolidada (V-01 a V-10).
- Figura 7. Conteo de severidad: 6 altos, 3 medios, 0 críticos.
- Figura 8. Validación de hardening SSH (PermitRootLogin, MaxAuthTries, LogLevel).
- Figura 9. Fail2Ban activo con jail sshd habilitado.
- Figura 10. Reglas UFW para bloqueo de puertos Docker expuestos en 0.0.0.0.
- Figura 11. Validación post-intervención: 0 archivos .env world-readable.
- Figura 12. Contenedores en estado Up tras mitigaciones Docker (pids-limit).
- Figura 13. Reglas auditd activas sobre archivos sensibles del sistema.
- Figura 14. Targets Prometheus en estado UP (Node Exporter).
- Figura 15. Dashboard operativo Grafana con métricas del host.

## Referencias (DOI)

- [1] S. Sultan, I. Ahmad, and T. Dimitriou, "Container Security: Issues, Challenges, and the Road Ahead," IEEE Access, vol. 7, pp. 52976-52996, 2019. https://doi.org/10.1109/ACCESS.2019.2911732
- [2] M. Souppaya, J. Morello, and K. Scarfone, "Application container security guide," NIST Special Publication 800-190, 2017. https://doi.org/10.6028/NIST.SP.800-190
- [3] National Institute of Standards and Technology, "The NIST Cybersecurity Framework (CSF) 2.0," NIST Cybersecurity White Paper, 2024. https://doi.org/10.6028/NIST.CSWP.29
- [4] M. S. Haq et al., "SoK: A Comprehensive Analysis and Evaluation of Docker Container Attack and Defense Mechanisms," in 2024 IEEE Symposium on Security and Privacy (SP), pp. 4573-4590, 2024. https://doi.org/10.1109/SP54263.2024.00268
- [5] A. Mills, J. White, and P. Legg, "Longitudinal risk-based security assessment of docker software container images," Computers & Security, vol. 135, art. 103478, 2023. https://doi.org/10.1016/j.cose.2023.103478
- [6] T. Alyas et al., "Container Performance and Vulnerability Management for Container Security Using Docker Engine," Security and Communication Networks, vol. 2022, pp. 1-11, 2022. https://doi.org/10.1155/2022/6819002
- [7] R. Rahman, M. Farel, and M. D. Sopan, "Implementasi Hardening Server Linux untuk Mengurangi Risiko Serangan Siber," Jurnal Riset Sistem Informasi, vol. 3, no. 2, pp. 39-44, 2026. https://doi.org/10.69714/c4atnn70
- [8] B. Irawan, K. N. Sheha, M. Rahaman, N. Erzed, and A. Herwanto, "Evaluating the Effectiveness of Center of Internet Security Benchmark for Hardening Linux Servers Against Cyber Attacks," Journal of Social Research, vol. 4, no. 6, pp. 1172-1183, 2025. https://doi.org/10.55324/josr.v4i6.2544
- [9] M. R. M. Ridho, A. Hafizh, I. Dani, and T. Ariyadi, "Peningkatan Keamanan SSH Server Berbasis Linux melalui Implementasi Fail2Ban dan Uji Serangan Brute Force," Jurnal Penelitian Multidisiplin Bangsa, vol. 1, no. 12, pp. 2206-2214, 2025. https://doi.org/10.59837/jpnmb.v1i12.431
- [10] A. Rustianto, A. Fadillah, and J. Kasih, "Pencegahan Dan Visualisasi Serangan Brute Force Menggunakan Fail2ban, Prometheus, dan Grafana," Jurnal Publikasi Teknik Informatika, vol. 4, no. 2, pp. 195-209, 2025. https://doi.org/10.55606/jupti.v4i2.5144
- [11] L. Bernardo, S. Malta, and J. Magalhães, "An Evaluation Framework for Cybersecurity Maturity Aligned with the NIST CSF," Electronics, vol. 14, no. 7, art. 1364, 2025. https://doi.org/10.3390/electronics14071364
- [12] Y. Shen and X. Yu, "Docker container hardening method based on trusted computing," Journal of Physics: Conference Series, vol. 1619, no. 1, art. 012014, 2020. https://doi.org/10.1088/1742-6596/1619/1/012014
- [13] M. Waseem, P. Liang, and M. Shahin, "A Systematic Mapping Study on Microservices Architecture in DevOps," Journal of Systems and Software, vol. 170, art. 110798, 2020. https://doi.org/10.1016/j.jss.2020.110798
- [14] M. Bahtiar, T. Taryo, and F. Aziz, "Evaluasi Tingkat Keamanan Server Linux Ubuntu melalui Penerapan CIS Benchmarks, OpenVAS, dan Lynis sebagai Upaya Mitigasi Vektor Serangan," INTECOMS: Journal of Information Technology and Computer Science, vol. 9, no. 2, pp. 296-301, 2026. https://doi.org/10.31539/ht1ydz84

> Versión portafolio: documento Word completo con figuras permanece en el repositorio privado del proyecto.

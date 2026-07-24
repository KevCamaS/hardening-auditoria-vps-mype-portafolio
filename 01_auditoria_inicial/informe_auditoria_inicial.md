# Informe de Auditoría Inicial y Plan de Remediación

## Proyecto: Hardening y auditoría de seguridad — VPS dockerizada MYPE

**Fase:** Auditoría inicial (solo lectura) — Actividades 1 a 8  
**Caso de estudio:** Una VPS Ubuntu en producción de una MYPE peruana del sector tecnológico  
**Metodología:** Cuasi-experimental — medición del estado de seguridad ANTES de la intervención (hardening)

---

## 1. Objetivo del informe

Documentar de forma consolidada los hallazgos de la auditoría inicial de solo lectura ejecutada sobre la VPS del caso de estudio, establecer la línea base medible del experimento y definir un plan de remediación priorizado que guiará las actividades de hardening (Act. 9 a 14), monitoreo complementario (Act. 15) y validación post-intervención (Act. 17 a 18).

---



## 2. Alcance



### 2.1 Incluido

- Reconocimiento de infraestructura (Act. 1)
- Inventario de servicios, puertos y arquitectura Docker (Act. 2)
- Auditoría del sistema operativo con Lynis (Act. 3)
- Escaneo de puertos con Nmap (Act. 4)
- Evaluación Docker con Docker Bench for Security (Act. 5)
- Clasificación de vulnerabilidades CIS/NIST (Act. 6)
- Revisión de permisos de archivos `.env` y secretos (Act. 7)
- Stack de monitoreo base desplegado en paralelo (Act. 16 adelantada): Prometheus, Grafana, Node Exporter



### 2.2 Excluido en esta fase

- Modificaciones de configuración del sistema operativo, SSH, firewall o contenedores (inician en Act. 9)
- Escaneo de vulnerabilidades en imágenes con Trivy (Act. 14)
- Despliegue de HIDS/SIEM Wazuh (Act. 15)
- Validación comparativa antes/después (Act. 17 a 18)



### 2.3 Restricción metodológica

Todas las actividades 1 a 8 se ejecutaron en modalidad **estrictamente de solo lectura**, sin alterar la configuración de aplicaciones de clientes en producción.

---



## 3. Descripción del entorno auditado


| Elemento             | Valor medido                                                |
| -------------------- | ----------------------------------------------------------- |
| Sistema operativo    | Ubuntu 22.04.5 LTS                                          |
| Kernel               | Linux 5.15.0-170-generic                                    |
| Virtualización       | KVM (VPS comercial)                                         |
| CPU                  | 4 vCPU                                                      |
| RAM                  | 3.8 GiB                                                     |
| Disco                | 194 GB (27% utilizado en /)                                 |
| Usuario operativo    | `mype` (grupos: sudo, docker)                               |
| Contenedorización    | Docker 29.2.1, Docker Compose v5.0.2                        |
| Acceso remoto        | SSH + overlay Tailscale                                     |
| Servicios relevantes | nginx, docker, mysql, ssh, aplicaciones web en contenedores |


---



## 4. Herramientas e instrumentos utilizados


| Actividad | Herramienta                                  | Propósito                                      |
| --------- | -------------------------------------------- | ---------------------------------------------- |
| 1-2       | SSH, hostnamectl, ss, docker CLI, find       | Reconocimiento e inventario                    |
| 3         | Lynis 3.0.7                                  | Hardening Index y auditoría del SO             |
| 4         | Nmap                                         | Puertos y servicios en escucha                 |
| 5         | Docker Bench for Security (CIS Docker 1.6.0) | Evaluación de seguridad Docker                 |
| 6         | Matriz propia CIS/NIST CSF                   | Consolidación y priorización                   |
| 7         | find, ls -la                                 | Permisos de archivos `.env` sin leer contenido |
| 16        | Prometheus, Grafana, Node Exporter           | Observabilidad operativa en tiempo real        |


---



## 5. Resultados de la auditoría (baseline ANTES)



### 5.1 Actividad 1 — Reconocimiento

Se confirmó un entorno Ubuntu 22.04 estable, con Docker operativo, múltiples servicios systemd activos (nginx, mysql, docker, ssh) y conectividad Tailscale para acceso remoto del equipo técnico.

### 5.2 Actividad 2 — Inventario

- **11 archivos docker-compose** identificados en rutas de desarrollo, producción y sitios web.
- **Múltiples contenedores activos** (aplicaciones frontend/backend, APIs, webhooks).
- **Al menos 6 contenedores en ejecución** con usuario por defecto (root).
- **Más de 15 redes Docker** bridge aisladas por proyecto.
- UFW en estado activo con reglas permisivas documentadas como baseline.



### 5.3 Actividad 3 — Lynis


| Métrica            | Resultado    |
| ------------------ | ------------ |
| Hardening Index    | **65 / 100** |
| Tests performed    | 265          |
| Warnings           | 3            |
| Suggestions        | 56           |
| Firewall detectado | Sí (UFW)     |
| Malware scanner    | No instalado |


**Warnings principales:** paquetes vulnerables desactualizados (PKGS-7392); nameserver overlay Tailscale sin respuesta al test IPv6 (NETW-2704/2705, esperable en entorno VPN).

### 5.4 Actividad 4 — Nmap

**16 puertos TCP abiertos** en escaneo local (127.0.0.1):


| Puerto                        | Servicio                           | Exposición                   |
| ----------------------------- | ---------------------------------- | ---------------------------- |
| 22, 80, 443                   | SSH, HTTP, HTTPS                   | Público (esperado)           |
| 1005, 3003, 3334, 3335, 4000  | Aplicaciones Docker                | Público (0.0.0.0) — hallazgo |
| 3306, 33060, 2368, 4687, 4688 | MySQL, Ghost, app-flow             | Solo localhost — aceptable   |
| 3000, 9090, 9100              | Grafana, Prometheus, Node Exporter | Solo localhost — correcto    |




### 5.5 Actividad 5 — Docker Bench


| Métrica | Resultado |
| ------- | --------- |
| Checks  | 117       |
| Score   | **5**     |
| PASS    | 46        |
| WARN    | 145       |
| INFO    | 74        |


Score muy bajo, coherente con contenedores en root, daemon Docker sin endurecer e imágenes sin escanear.

### 5.6 Actividad 6 — Matriz CIS/NIST

**10 hallazgos consolidados:**


| ID   | Severidad | Hallazgo resumido                    |
| ---- | --------- | ------------------------------------ |
| V-01 | Medio     | Hardening Index 65/100               |
| V-02 | Alto      | Paquetes vulnerables desactualizados |
| V-03 | Medio     | Sin Fail2Ban                         |
| V-04 | Alto      | SSH permisivo                        |
| V-05 | Medio     | Sin auditd/HIDS                      |
| V-06 | Alto      | Puertos apps Docker en 0.0.0.0       |
| V-07 | Medio     | SSH 22 expuesto globalmente          |
| V-08 | Alto      | Docker Bench score 5, 145 WARN       |
| V-09 | Alto      | Contenedores en root                 |
| V-10 | Alto      | 32 archivos `.env` world-readable    |


**Conteo:** Crítico 0 | Alto 6 | Medio 3 | Bajo 0

### 5.7 Actividad 7 — Secretos y variables de entorno

- **32 archivos** `.env` identificados en rutas de desarrollo, producción y monitoreo.
- **32 archivos con permisos world-readable** (664/644): cualquier usuario del sistema podría leer secretos (passwords, tokens, claves API).
- **Meta post-hardening:** 0 archivos `.env` world-readable; permisos objetivo 600 o 640.



### 5.8 Actividad 16 — Monitoreo (adelantada)

Stack Prometheus + Grafana + Node Exporter desplegado en `/opt/monitoring`, con acceso a Grafana vía Nginx y restricción por IP Tailscale. Roles Grafana: Admin (equipo técnico) y Viewer restringido a carpeta Operaciones (colaboradores). Prometheus y Node Exporter en localhost; acceso administrativo vía túnel SSH.

---



## 6. Análisis de riesgo (síntesis)

La VPS presenta un nivel de madurez en seguridad **medio-bajo** para un entorno con aplicaciones de clientes en producción:

1. **Superficie de ataque amplia:** múltiples puertos de aplicación expuestos en 0.0.0.0 sin reverse proxy centralizado.
2. **Gestión de secretos deficiente:** 100% de archivos `.env` auditados son world-readable.
3. **Docker sin endurecer:** score CIS 5/117; contenedores privilegiados.
4. **Controles de detección ausentes:** sin Fail2Ban, sin auditd/HIDS (Wazuh pendiente).
5. **Observabilidad parcialmente resuelta:** monitoreo de métricas operativas implementado; detección de intrusiones pendiente.

---



## 7. Plan de remediación priorizado



### Prioridad 1 — Crítica / Alta (Act. 9 a 13)


| Orden | Actividad  | Acción                                                          | Hallazgos que resuelve |
| ----- | ---------- | --------------------------------------------------------------- | ---------------------- |
| 1     | Pre-Act. 9 | Snapshot confirmado + consola emergencia                        | Respaldo obligatorio   |
| 2     | Act. 9     | Actualización paquetes, sysctl, banners, PAM                    | V-01, V-02             |
| 3     | Act. 10    | Hardening SSH (sin root, MaxAuthTries, claves)                  | V-04, V-07             |
| 4     | Act. 11    | UFW mínimo privilegio                                           | V-06, V-07             |
| 5     | Act. 12    | Fail2Ban                                                        | V-03                   |
| 6     | Act. 13    | Docker: no-root, límites, redes, `.env` 600/640, bind localhost | V-06, V-08, V-09, V-10 |




### Prioridad 2 — Media (Act. 14 a 16)


| Orden | Actividad | Acción                               |
| ----- | --------- | ------------------------------------ |
| 7     | Act. 14   | Trivy — escaneo CVE en imágenes      |
| 8     | Act. 15   | Wazuh + Auditd (HIDS)                |
| 9     | Act. 16   | Completar monitoreo (HTTPS, alertas) |




### Prioridad 3 — Validación (Act. 17 a 18)


| Orden | Actividad | Acción                                       |
| ----- | --------- | -------------------------------------------- |
| 10    | Act. 17   | Re-ejecutar Lynis, Nmap, Docker Bench, Trivy |
| 11    | Act. 18   | Tabla comparativa antes/después con % mejora |


---



## 8. Métricas objetivo post-hardening


| Métrica                           | Baseline (ANTES)   | Meta (DESPUÉS)                               |
| --------------------------------- | ------------------ | -------------------------------------------- |
| Lynis Hardening Index             | 65                 | ≥ 80                                         |
| Docker Bench WARN                 | 145                | Reducción sustancial                         |
| Puertos TCP públicos innecesarios | 5+ apps en 0.0.0.0 | Solo 22, 80, 443 (+ necesarios justificados) |
| `.env` world-readable             | 32                 | 0                                            |
| Contenedores en root              | 6+                 | Reducción significativa / 0                  |
| Fail2Ban activo                   | No                 | Sí                                           |
| HIDS operativo                    | No                 | Sí (Wazuh)                                   |


---



## 9. Autorización para inicio de hardening

Se recibió **constancia formal** del responsable técnico de la MYPE confirmando:

- Ejecución de **snapshot de respaldo** de la VPS antes de la Actividad 9.
- Disponibilidad de **acceso de emergencia** al proveedor de hosting.
- **Autorización** para iniciar actividades de hardening a partir de la Actividad 9.

**Referencia:** Constancia de respaldo (snapshot) y autorización para inicio de hardening — 12/07/2026 — Ing. Kevin Jhosep Ramos Chumpitaz.

---



## 10. Conclusiones del informe

La auditoría inicial de solo lectura estableció una **línea base documentada y reproducible** del estado de seguridad de la VPS de la MYPE. Los resultados cuantitativos (Hardening Index 65, Docker Bench score 5, 32 `.env` expuestos, 16 puertos TCP abiertos) demuestran la necesidad de intervención sistemática de hardening.

El plan de remediación priorizado define una secuencia controlada: respaldo → endurecimiento SO/SSH/UFW → protección Docker y secretos → detección (Wazuh/Fail2Ban) → validación empírica antes/después.

Con este informe se **cierra la Fase de Auditoría Inicial (Act. 1 a 8)** y se autoriza el inicio de la **Fase de Hardening (Act. 9 en adelante)**.

---



## 11. Evidencias asociadas


| Actividad | Archivos / capturas                                          |
| --------- | ------------------------------------------------------------ |
| 1-2       | `01_auditoria_inicial/inventario/`, `S0_Act1_*`, `S0_Act2_*` |
| 3         | `01_auditoria_inicial/lynis/`, `S1_Act3_*`                   |
| 4         | `01_auditoria_inicial/nmap/`, `S1_Act4_*`                    |
| 5         | `01_auditoria_inicial/docker_bench/`, `S2_Act5_*`            |
| 6         | `matriz_vulnerabilidades_antes.md`, `S2_Act6_*`              |
| 7         | `env_secretos/`, `S3_Act7_*`                                 |
| 8         | Este informe, `S3_Act8_*`                                    |
| 16        | `03_monitoreo/`, `S7_Act16_*`                                |


---

**Elaborado por:** Responsable del proyecto (portfolio anonimizado)
**Organización:** La MYPE (caso de estudio)  
**Estado:** Auditoría inicial cerrada — autorizado inicio hardening Act. 9
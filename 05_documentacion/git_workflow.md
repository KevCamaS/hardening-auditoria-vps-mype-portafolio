# Flujo Git — subir avance por actividad

Repositorio remoto: `https://github.com/KevCamaS/hardening-auditoria-vps-mype-2026.git`

## Archivos que NO se suben (`.gitignore`)

- `contexto_maestro.md`, `bases_feria.md` — planificación interna
- `*.env`, claves, secretos
- `lynis_antes.log`, `lynis-report_antes.dat` — logs muy verbosos
- `.cursor/`, `.vscode/`

## Primera vez — inicializar repo (solo una vez)

```powershell
cd D:\hardening-auditoria-vps-mype-2026
git init
git branch -M main
git remote add origin https://github.com/KevCamaS/hardening-auditoria-vps-mype-2026.git
```

---

## Bloque A — Act. 1–2 + monitoreo + Act. 3–5 (ahora)

Después de bajar evidencias de la VPS a `D:\hardening-auditoria-vps-mype-2026\`:

```powershell
cd D:\hardening-auditoria-vps-mype-2026
git add README.md .gitignore scripts/ 00_gestion_scrum/ 01_auditoria_inicial/ 02_hardening/ 03_monitoreo/ 04_pruebas_post_hardening/ 05_documentacion/ 06_paper/ evidencias/
git status
git commit -m "feat: auditoria inicial act 1-5 y stack monitoreo base (sprint 0-2)"
git push -u origin main
```

---

## Bloque B — Act. 6 (matriz CIS/NIST)

Completar `01_auditoria_inicial/matriz_cis_nist/matriz_vulnerabilidades_antes.md`, luego:

```powershell
cd D:\hardening-auditoria-vps-mype-2026
git add 01_auditoria_inicial/matriz_cis_nist/
git commit -m "docs: act 6 matriz vulnerabilidades CIS/NIST baseline"
git push
```

---

## Bloque C — Act. 7 (secretos .env)

```powershell
git add 01_auditoria_inicial/env_secretos/ evidencias/sprint3/
git commit -m "audit: act 7 revision permisos env y secretos"
git push
```

---

## Bloque D — Act. 8 (informe auditoría inicial)

```powershell
git add 01_auditoria_inicial/informe_auditoria_inicial.md 05_documentacion/
git commit -m "docs: act 8 informe auditoria inicial y plan remediacion"
git push
```

---

## Bloque E — Act. 9–14 (hardening)

```powershell
git add 02_hardening/ scripts/ evidencias/sprint4/ evidencias/sprint5/ evidencias/sprint6/
git commit -m "feat: hardening SO SSH UFW fail2ban docker trivy (act 9-14)"
git push
```

---

## Bloque F — Act. 15–16 + post-prueba 17–18

```powershell
git add 03_monitoreo/ 04_pruebas_post_hardening/ evidencias/sprint7/ evidencias/sprint8/
git commit -m "feat: wazuh monitoreo y validacion post-hardening (act 15-18)"
git push
```

---

## Bloque G — Cierre 19–20 (paper + portfolio)

```powershell
git add README.md .gitignore
git add 01_auditoria_inicial/ 02_hardening/ 03_monitoreo/ 05_documentacion/
git add scripts/ evidencias/
git add 06_paper/ArticuloCientifico_Hardening_Auditoria_VPS_MYPE*.docx
git add 06_paper/ArticuloCientifico_Hardening_Auditoria_VPS_MYPE.md
git add 06_paper/generar_articulo_anexo1_feinfo.py
git status
git commit -m "docs: paper científico con evidencias y portfolio completo del proyecto"
git push
```

**Importante:** subir solo archivos `*_anon.txt` de auditoría (los originales con rutas reales están en `.gitignore`).

---

## Limpieza final antes de presentación pública

Revisar que no existan en el historial:

- IPs públicas reales en capturas (anonimizar si hace falta)
- Dominios o nombres comerciales en PNG (`evidencias/sprint4/`, nginx, etc.)
- `contexto_maestro.md`, `bases_feria.md`
- Archivos crudos: `env_world_readable.txt`, `env_permisos_antes.txt`, `act1_reconocimiento.txt` (usar `*_anon.txt`)
- passwords en capturas de `.env`
- Documentos JEPA, entrega corporativa o PPT con datos internos

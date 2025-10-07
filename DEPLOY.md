# 📋 Configuration n8n avec community node MCP sur Render

**Date :** 07/10/2025  
**Service :** n8n sur Render.com  
**URL :** https://n8n-uv6j.onrender.com  
**Base de données :** Supabase PostgreSQL

---

## ✅ Dockerfile fonctionnel (n8n 1.114.3)

```dockerfile
FROM n8nio/n8n:1.114.3
ENV N8N_COMMUNITY_NODES_ENABLED=true
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true
USER root
RUN npm install -g n8n-nodes-mcp
USER node
# Ne pas redéfinir WORKDIR ni CMD, utiliser ceux de l'image de base
```

### ⚠️ Points critiques

- **NE PAS** ajouter `WORKDIR /data` → casse le PATH
- **NE PAS** ajouter `CMD ["n8n", "start"]` → l'image de base le gère déjà
- **NE PAS** réinstaller n8n avec `npm install -g n8n` → déjà présent dans l'image
- **TOUJOURS** utiliser `USER root` pour installer les nodes, puis revenir à `USER node`

---

## 🔐 Configuration Supabase (render.yaml)

### Variables publiques (dans le YAML)
```yaml
envVars:
  - key: DB_TYPE
    value: postgresdb
  - key: DB_POSTGRESDB_HOST
    value: aws-0-eu-central-1.pooler.supabase.com
  - key: DB_POSTGRESDB_DATABASE
    value: postgres
  - key: DB_POSTGRESDB_PORT
    value: 5432
  - key: N8N_ENCRYPTION_KEY
    generateValue: true
```

### Variables secrètes (dans Render Dashboard)
À configurer manuellement dans **Environment** :
- `DB_POSTGRESDB_USER` = `postgres.uuugziikkmtpnwjfodcv`
- `DB_POSTGRESDB_PASSWORD` = `R8netNxSHhUSMbeK`

**⚠️ JAMAIS en clair dans le YAML !**

---

## 🚨 Problèmes rencontrés et solutions

### Erreur : "Command n8n not found"
**Cause :** `WORKDIR /data` ou `CMD` redéfini dans le Dockerfile  
**Solution :** Ne pas redéfinir WORKDIR ni CMD, laisser ceux de l'image de base

### Erreur : "Tenant or user not found"
**Cause :** Services Supabase en pause  
**Solution :** Aller sur supabase.com et réactiver les services

### Erreur : "EACCES: permission denied"
**Cause :** Installation npm sans droits root  
**Solution :** Utiliser `USER root` avant `npm install`, puis `USER node`

---

## 📦 Structure des fichiers

```
projet/
├── Dockerfile (version ci-dessus)
├── render.yaml (avec secrets sécurisés)
└── .gitignore (exclure les credentials locaux)
```

---

## 🔄 Procédure de déploiement

1. **Modifier le code**
2. **Commit & push sur GitHub**
   ```bash
   git add .
   git commit -m "description"
   git push
   ```
3. **Render détecte et déploie automatiquement**
4. **Vérifier les logs** : Render Dashboard → Logs

---

## ⚙️ Variables d'environnement recommandées

```yaml
# Configuration n8n
- key: N8N_HOST
  value: 0.0.0.0
- key: N8N_PORT
  value: 5678
- key: N8N_PROTOCOL
  value: https
- key: WEBHOOK_URL
  value: https://n8n-uv6j.onrender.com

# Localisation
- key: GENERIC_TIMEZONE
  value: Europe/Paris
- key: TZ
  value: Europe/Paris
- key: N8N_DEFAULT_LOCALE
  value: fr

# Performance (plan free)
- key: NODE_OPTIONS
  value: --max-old-space-size=460

# Suppression des warnings
- key: N8N_RUNNERS_ENABLED
  value: "true"
- key: N8N_BLOCK_ENV_ACCESS_IN_NODE
  value: "false"
- key: N8N_GIT_NODE_DISABLE_BARE_REPOS
  value: "true"
```

---

## 📝 Notes importantes

- **Migration Supabase** : Effectuée le 03/07/2025 depuis PostgreSQL Render
- **Community node MCP** : Installé globalement pour être accessible partout
- **Sécurité** : Credentials uniquement dans Render Dashboard, jamais dans Git
- **Version n8n** : 1.114.3 (vérifier régulièrement les mises à jour)

---

## 🆘 Troubleshooting rapide

| Problème | Solution rapide |
|----------|----------------|
| Container ne démarre pas | Vérifier les logs Render |
| "Command not found" | Ne pas redéfinir WORKDIR/CMD |
| Erreur DB | Vérifier que Supabase n'est pas en pause |
| Community node non détecté | Vérifier `N8N_COMMUNITY_NODES_ENABLED=true` |
| Permissions config file | Vérifier `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true` |

---

## 📚 Ressources

- [Documentation n8n](https://docs.n8n.io/)
- [n8n-nodes-mcp](https://www.npmjs.com/package/n8n-nodes-mcp)
- [Render Docker Deploy](https://render.com/docs/deploy-an-image)
- [Supabase Connection](https://supabase.com/docs/guides/database/connecting-to-postgres)

---

**✅ Configuration validée et fonctionnelle le 07/10/2025**

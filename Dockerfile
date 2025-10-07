# --- Base image paramétrable ---
ARG N8N_VERSION=1.91.3
FROM n8nio/n8n:${N8N_VERSION}

# --- Working directory ---
WORKDIR /data

# --- Install Community Node MCP ---
RUN npm install --prefix /data n8n-nodes-mcp

# --- Enable Community Nodes ---
ENV N8N_COMMUNITY_NODES_ENABLED=true
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# --- Fix permissions (non bloquant) ---
RUN chmod 600 /home/node/.n8n/config || true

# ⚠️ Ne redéfinis PAS CMD ici !
# L'image de base possède déjà :
#   USER node
#   CMD ["tini", "--", "n8n"]

# Si tu veux forcer le user (optionnel mais safe)
USER node

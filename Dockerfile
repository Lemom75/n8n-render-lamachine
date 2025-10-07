# --- Base image ---
FROM n8nio/n8n:1.114.3

# --- Enable Community Nodes ---
ENV N8N_COMMUNITY_NODES_ENABLED=true

# --- Enforce correct permissions ---
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# --- Désactiver les warnings de dépréciation (optionnel) ---
ENV N8N_RUNNERS_ENABLED=true
ENV N8N_BLOCK_ENV_ACCESS_IN_NODE=false
ENV N8N_GIT_NODE_DISABLE_BARE_REPOS=true

# --- Switch to root to install community node ---
USER root

# --- Install the community node MCP globally ---
RUN npm install -g n8n-nodes-mcp

# --- Switch back to node user ---
USER node

# --- IMPORTANT : Ne pas changer le WORKDIR ! ---
# L'image de base utilise /home/node par défaut

# --- Start n8n (format exact qui a fonctionné) ---
CMD ["n8n"]

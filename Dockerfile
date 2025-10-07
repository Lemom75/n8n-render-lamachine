FROM n8nio/n8n:1.114.3

ENV N8N_COMMUNITY_NODES_ENABLED=true
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

USER root
RUN npm install -g n8n-nodes-mcp
USER node

WORKDIR /home/node

# Utiliser le chemin complet vers l'exécutable n8n
CMD ["node", "/usr/local/bin/n8n"]

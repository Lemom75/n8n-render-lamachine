FROM n8nio/n8n:latest

# On place le WORKDIR sur /data (bonne pratique pour n8n)
WORKDIR /data

# Installation du node communautaire MCP (sans -g)
RUN npm install --prefix /data n8n-nodes-mcp

# Active les Community Nodes
ENV N8N_COMMUNITY_NODES_ENABLED=true

# On lance n8n (déjà présent globalement dans l’image)
CMD ["n8n", "start"]

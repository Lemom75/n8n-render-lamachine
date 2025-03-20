FROM n8nio/n8n:latest

WORKDIR /data

RUN npm install --prefix /data n8n-nodes-mcp

ENV N8N_COMMUNITY_NODES_ENABLED=true

CMD ["n8n", "start"]

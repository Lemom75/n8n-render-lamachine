FROM n8nio/n8n:latest

RUN npm install -g n8n-nodes-mcp

ENV N8N_COMMUNITY_NODES_ENABLED=true

WORKDIR /data

CMD ["n8n", "start"]
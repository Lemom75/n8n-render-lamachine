FROM n8nio/n8n:latest

WORKDIR /data

RUN npm install n8n-nodes-mcp

ENV N8N_COMMUNITY_NODES_ENABLED=true

CMD ["./node_modules/.bin/n8n", "start"]
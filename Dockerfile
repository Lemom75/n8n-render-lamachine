FROM n8nio/n8n:latest

WORKDIR /data

# ✅ Force install n8n globally (in case Render strips it)
RUN npm install -g n8n

# ✅ Install your MCP community node locally
RUN npm install --prefix /data n8n-nodes-mcp

# ✅ Enable Community Nodes
ENV N8N_COMMUNITY_NODES_ENABLED=true

# ✅ Start n8n using the global installation
CMD ["n8n", "start"]
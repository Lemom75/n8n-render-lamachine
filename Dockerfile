FROM n8nio/n8n:latest

# Set the working directory
WORKDIR /data

# ✅ Install the MCP community node LOCALLY (no -g, avoids permission issues)
RUN npm install --prefix /data n8n-nodes-mcp

# ✅ Enable community nodes
ENV N8N_COMMUNITY_NODES_ENABLED=true

# ✅ Run n8n - already installed globally in the official image PATH
CMD ["n8n", "start"]

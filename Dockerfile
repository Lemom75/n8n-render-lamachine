FROM n8nio/n8n:latest

# Install the MCP community node
RUN npm install n8n-nodes-mcp

# Enable community nodes
ENV N8N_COMMUNITY_NODES_ENABLED=true

# Start n8n
CMD ["n8n", "start"]

FROM n8nio/n8n:1.91.3

# Set the WORKDIR to /data (best practice for n8n)
WORKDIR /data

# Install the community node MCP (without -g)
RUN npm install --prefix /data n8n-nodes-mcp

# Enable Community Nodes
ENV N8N_COMMUNITY_NODES_ENABLED=true

# Fix permissions for the n8n settings file
RUN chmod 600 /home/node/.n8n/config

# Ensure n8n is installed and available
RUN npm install -g n8n

# Start n8n (already globally in the image)
CMD ["n8n", "start"]

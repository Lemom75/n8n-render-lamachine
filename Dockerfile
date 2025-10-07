# --- Base image ---
FROM n8nio/n8n:1.114.3

# --- Set working directory (best practice for n8n) ---
WORKDIR /data

# --- Install the community node MCP ---
RUN npm install --prefix /data n8n-nodes-mcp

# --- Enable Community Nodes ---
ENV N8N_COMMUNITY_NODES_ENABLED=true

# --- Fix permissions for the n8n settings file (ignore if missing) ---
RUN chmod 600 /home/node/.n8n/config || true

# --- Start n8n via shell (ensures PATH is loaded) ---
CMD ["sh", "-c", "n8n start"]

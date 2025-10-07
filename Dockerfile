# --- Base image ---
FROM n8nio/n8n:1.91.3

# --- Set working directory (best practice for n8n) ---
WORKDIR /data

# --- Install the community node MCP ---
RUN npm install --prefix /data n8n-nodes-mcp

# --- Enable Community Nodes ---
ENV N8N_COMMUNITY_NODES_ENABLED=true

# --- Fix permissions for the n8n settings file (ignore if missing) ---
RUN chmod 600 /home/node/.n8n/config || true

# --- Ensure n8n is installed and available globally ---
RUN npm install -g n8n

# --- Default command to start n8n ---
CMD ["n8n", "start"]

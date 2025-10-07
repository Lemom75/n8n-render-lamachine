# --- Base image ---
FROM n8nio/n8n:1.114.3

# --- Enable Community Nodes ---
ENV N8N_COMMUNITY_NODES_ENABLED=true

# --- Enforce correct permissions for config file ---
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# --- Switch to root to install community node ---
USER root

# --- Install the community node MCP globally ---
RUN npm install -g n8n-nodes-mcp

# --- Switch back to node user for security ---
USER node

# --- Use default working directory from base image ---
WORKDIR /home/node

# --- Start n8n ---
CMD ["n8n", "start"]

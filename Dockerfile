# --- Base image ---
FROM n8nio/n8n:1.114.3

# --- Enable Community Nodes ---
ENV N8N_COMMUNITY_NODES_ENABLED=true

# --- Fix permissions warning ---
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# --- Switch to root to install community node ---
USER root

# --- Install the community node MCP in the correct location ---
RUN cd /usr/local/lib/node_modules/n8n && \
    npm install n8n-nodes-mcp && \
    chown -R node:node /usr/local/lib/node_modules/n8n/node_modules/n8n-nodes-mcp

# --- Switch back to node user ---
USER node

# --- Use the default working directory from base image ---
WORKDIR /home/node

# --- The CMD is already defined in the base image, but we can be explicit ---
CMD ["n8n"]

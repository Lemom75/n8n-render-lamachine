# --- Base image ---
FROM n8nio/n8n:1.114.3

# --- Enable Community Nodes ---
ENV N8N_COMMUNITY_NODES_ENABLED=true

# --- Enforce correct permissions ---
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# --- Switch to root temporarily for installation ---
USER root

# --- Install the community node MCP globally ---
RUN npm install -g n8n-nodes-mcp

# --- Switch back to node user ---
USER node

# --- Reset to default working directory from base image ---
WORKDIR /home/node

# --- Use the exact same CMD as the base image (no arguments) ---
CMD ["n8n"]

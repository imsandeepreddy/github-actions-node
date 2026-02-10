# 1. Base image
FROM node:20-alpine

# 2. Set working directory
WORKDIR /app

# 3. Copy dependency manifests first (layer caching)
COPY package*.json ./

# 4. Install dependencies (CI-safe)
RUN npm install --production

# 5. Copy application source
COPY index.js .

# 6. Expose app port
EXPOSE 3000

HEALTHCHECK --interval=5s --timeout=2s --retries=5 \
  CMD wget -qO- http://localhost:3000 || exit 1

# 7. Start application
CMD ["node", "index.js"]
# Dockerfile for backend and frontend static hosting
FROM node:22-alpine AS builder
WORKDIR /app

# Copy backend files and install dependencies
COPY backend/package*.json backend/
RUN npm install --prefix backend

# Copy full source
COPY backend/ backend/
COPY frontend/ frontend/

# Build static assets if frontend had a build step (not present here)
# For this simple static site, just copy the frontend files as-is.

FROM node:22-alpine
WORKDIR /app
COPY --from=builder /app/backend ./backend
COPY --from=builder /app/frontend ./frontend

WORKDIR /app/backend
EXPOSE 3000
CMD ["node", "server.js"]

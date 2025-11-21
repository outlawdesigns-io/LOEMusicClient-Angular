# --- Build stage ---
FROM node:20-bullseye AS build
WORKDIR /app

# Copy dependencies first for caching
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Build the Vite app
RUN npm run build

# --- Runtime stage ---
FROM node:20-bullseye
WORKDIR /app
RUN mkdir /log

# Copy built app from build stage
COPY --from=build /app/dist ./dist
COPY entrypoint.sh ./entrypoint.sh

# Install a tiny static server, e.g. serve
RUN npm install -g @outlawdesigns/static-express-server

# Expose port
EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]
CMD ["/bin/sh","-c","static-express-server > /log/loe-music-app.log"]

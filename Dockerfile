# Stage 1: Build Angular App
FROM node:18-alpine AS builder

# Set environment variables
ARG APP_VERSION=dev
ENV NODE_ENV=production \
    APP_VERSION=$APP_VERSION

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci

# Copy application source code
COPY . .

# Install Angular CLI and build the app
RUN npm install -g @angular/cli@17.3.5 && \
    ng build --configuration production

# Stage 2: Serve app with Nginx
FROM nginx:alpine

# Remove default Nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from builder stage
COPY --from=builder /app/dist/* /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK CMD curl --fail http://localhost/ || exit 1

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]


# Stage 1: Build the Angular application
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci 

# Copy the application source code
COPY . ./

# Set environment variable (optional, but can help in some cases)
ENV PATH="/app/node_modules/.bin:$PATH"

# Build the Angular application for production
RUN npm run build 

# Stage 2: Serve the Angular application using Nginx
FROM nginx:1.23-alpine

# Set the document root
RUN rm -rf /usr/share/nginx/html
RUN mkdir -p /usr/share/nginx/html

# Copy the built Angular application from the builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 for HTTP
EXPOSE 80

# Set user and group for Nginx processes
USER nginx

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

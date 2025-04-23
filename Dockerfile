    # Stage 1: Build the Angular application
    FROM node:18-alpine AS builder
    WORKDIR /app

    # Copy package.json and package-lock.json
    COPY package*.json ./

    # Install dependencies
    RUN npm ci --only=production

    # Copy the application source code
    COPY . ./

    # Build the Angular application for production
    RUN npm run build -- --output-path=dist

    # Stage 2: Serve the Angular application using Nginx
    FROM nginx:1.23-alpine

    # Set the document root
    RUN rm -rf /usr/share/nginx/html
    RUN mkdir -p /usr/share/nginx/html

    # Create cache directory and set permissions
    RUN mkdir -p /var/cache/nginx
    RUN chown -R nginx:nginx /var/cache/nginx

    # Copy the built Angular application from the builder stage
    COPY --from=builder /app/dist /usr/share/nginx/html

    # Copy custom Nginx configuration (optional)
    COPY ./nginx.conf /etc/nginx/conf.d/default.conf

    # Expose port 80 for HTTP
    EXPOSE 80

    # Use a non-root user for Nginx (security best practice)
    RUN adduser -D -u 1001 nginx

    # Set user and group for Nginx processes
    USER nginx

    # Start Nginx
    CMD ["nginx", "-g", "daemon off;"]
    

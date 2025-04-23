# Stage 1: Build the Angular application
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application source code
COPY . .

# Build the Angular application for production
RUN npm run build -- --prod

# Stage 2: Serve the Angular application using Nginx
FROM nginx:alpine

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy the built Angular application from the builder stage
COPY --from=builder /app/dist/<your-project-name> /usr/share/nginx/html

# Copy custom Nginx configuration (optional)
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for HTTP
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]

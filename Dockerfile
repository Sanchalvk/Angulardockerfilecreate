# Stage 1: Build Angular application
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

# Replace this with your actual Angular project name inside 'dist/' (after build)
# Run `ls dist/` locally to confirm it
COPY --from=builder /app/dist/your-project-name /usr/share/nginx/html

# Optional: Only include this line if 'nginx.conf' exists in your root directory
# If you don't have one yet, create it or comment out this line
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

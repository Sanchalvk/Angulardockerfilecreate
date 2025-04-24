# Stage 1: Build Angular App
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Angular app
RUN npm install -g @angular/cli && \
    ng build --configuration production

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the build output to Nginx HTML folder
COPY --from=builder /app/dist/your-project-name /usr/share/nginx/html

# Copy custom nginx config if needed (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

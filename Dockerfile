# Stage 1: Build Angular app
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the entire project
COPY . .

# Build the Angular project (default prod config)
RUN npm run build --prod

# Replace 'sample-app' with your actual dist folder name after build
# You can confirm it by checking: `ls dist/`
# For example, if `dist/sample-app` is the output, use that below

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Clean default nginx html
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app
COPY --from=builder /app/dist/sample-app /usr/share/nginx/html

# Copy default nginx config (optional for SPA routing)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


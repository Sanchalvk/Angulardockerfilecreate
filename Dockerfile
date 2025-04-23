# Use an official Node.js runtime as the base image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files into the working directory
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the entire Angular project into the working directory
COPY . .

# Build the Angular application
RUN npm run build --prod

# Use an official NGINX image for serving the Angular app
FROM nginx:alpine

# Copy built Angular files to the NGINX serving directory
COPY --from=0 /app/dist/YOUR_PROJECT_NAME /usr/share/nginx/html

# Expose the port the app runs on
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

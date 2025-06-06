# Stage 1: Build
FROM node:18-alpine as build
WORKDIR /app
COPY . .
RUN npm install && npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/your-angular-app-name /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

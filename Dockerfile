FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY --from=builder /app/dist/your-project-name /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Use existing non-root nginx user
USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

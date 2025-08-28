# Use official Nginx image to serve static HTML
FROM nginx:alpine

# Copy website files to nginx html directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

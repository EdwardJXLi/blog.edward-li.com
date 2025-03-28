# Use the official Hugo image as a builder
FROM klakegg/hugo:0.121.1-alpine AS builder

# Set working directory
WORKDIR /src

# Copy the entire project
COPY . .

# Build the site
RUN hugo --minify

# Use Nginx for serving the static site
FROM nginx:alpine

# Copy the built site from the builder stage
COPY --from=builder /src/public /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to run when container starts
CMD ["nginx", "-g", "daemon off;"]
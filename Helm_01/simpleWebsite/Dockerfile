FROM nginx:1.26-alpine

# Remove the default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy the website from the build context
COPY . /usr/share/nginx/html/

# Nginx listens on port 80
EXPOSE 80
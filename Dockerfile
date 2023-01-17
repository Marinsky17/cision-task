# Alpine is minimalistic and lightweight, perfect for a security, isolated environment.
FROM alpine:3.12

# Install nginx
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/community" >> /etc/apk/repositories && \
    apk add --no-cache nginx=1.19.4-r0

# Add the local default configuration file.
COPY default.conf /etc/nginx/conf.d/default.conf

# This is a step further-increasing security but not entirely necessary. If chosen, nginx will be run as a non-root user.
RUN adduser -D -g 'sample-user' sample-user && \
    chown -R sample-user:sample-user /var/lib/nginx
USER sample-user

# Expose port 80
EXPOSE 80

# Start nginx in the foreground for log aggregation. By choice, remove "deamon off" in order to run nginx in the background by default.
CMD ["nginx", "-g", "daemon off;"]

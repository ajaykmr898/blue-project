# Base image
FROM alpine:latest

# Install dependencies
RUN apk update && \
    apk add --no-cache nodejs=10.24.1-r0 && \
    npm install -g @angular/cli@7.3.10 && \
    apk add --no-cache python2=2.7.18-r0

# Expose port 4200
EXPOSE 4200

CMD ["tail", "-f"]

WORKDIR /var/www/html/blue-project/

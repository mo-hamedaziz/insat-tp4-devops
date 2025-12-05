FROM alpine:latest

RUN apk update && \
    apk add nginx && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/http.d/default.conf
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM ubuntu:20.04

RUN apt update && apt install -y -q nginx

RUN rm /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/

COPY index.html /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
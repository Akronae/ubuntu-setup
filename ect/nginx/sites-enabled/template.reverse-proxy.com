
server {
    server_name template.reverse-proxy.com;
    listen 80;
    listen [::]:80;

    root /var/www/template.reverse-proxy.com;
    index index.html index.htm index.nginx-debian.html;

    access_log /var/log/nginx/template.reverse-proxy.com-access.log;
    error_log /var/log/nginx/template.reverse-proxy.com-error.log;

    location / {
        proxy_pass http://localhost:3330/template/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

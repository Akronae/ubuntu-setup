server {
    listen 80;
    listen [::]:80;

    server_name *.subdomains-https-reverse-example.com;

    add_header Access-Control-Allow-Origin *;
    return 301 https://$host$request_uri;
}


server {
    listen 443 ssl;

    server_name *.subdomains-https-reverse-example.com;

    ssl_certificate /etc/letsencrypt/live/*.subdomains-https-reverse-example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/*.subdomains-https-reverse-example.com/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    root /var/www/*.subdomains-https-reverse-example.com;
    index index.html;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass $scheme://$host;
    }
}

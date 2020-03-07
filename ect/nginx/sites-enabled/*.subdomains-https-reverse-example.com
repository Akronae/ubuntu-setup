server {
    listen 80;
    listen [::]:80;

    # <=> *.app-maville.com, with subdomain extracted to $subdomain
    server_name ~^(?<subdomain>.+)\.app-maville\.com$;

    add_header Access-Control-Allow-Origin *;

    # www is set to default subdomain
    if ($subdomain = '') {
        return 301 $scheme://www.$host$request_uri;
    }

    return 301 https://$host$request_uri;
}


server {
    listen 443 ssl;

    server_name *.app-maville.com;

    ssl_certificate /etc/letsencrypt/live/app-maville.com-0001/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/app-maville.com-0001/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    root /var/www/*.app-maville.com;
    index index.html;

    location / {
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass $scheme://$host;
    }
}

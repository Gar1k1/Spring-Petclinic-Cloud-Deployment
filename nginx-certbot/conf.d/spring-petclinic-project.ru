server {
        listen 80;
        listen [::]:80;

        root /var/www/spring-petclinic-project.ru/html;
        index index.html index.htm index.nginx-debian.html;

        server_name spring-petclinic-project.ru www.spring-petclinic-project.ru;
        server_tokens off;
        location / {
                try_files $uri $uri/ =404;
        }
}

server {
    listen  443  ssl;
    server_name spring-petclinic-project.ru;
    server_tokens off;

    ssl_certificate /etc/letsencrypt/live/spring-petclinic-project.ru/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/spring-petclinic-project.ru/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass http://petclinic:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}

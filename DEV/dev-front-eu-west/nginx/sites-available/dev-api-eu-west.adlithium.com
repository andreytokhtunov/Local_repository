
server {
    listen 10.132.0.3:80 default_server;

    server_name dev-api-eu-west.adlithium.com;
    root /home/rtb/sites/g-api.adlithium.com/htdocs;

    keepalive_timeout 70;
    
    include white.list;

    location / {
        if ($request ~* https?://) { return 400; }

        proxy_set_header X-FORWARDED-PROTO https;
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
    }
}

server {
    listen 10.132.0.3:443 default_server ssl;

    server_name dev-api-eu-west.adlithium.com;
    root /home/rtb/sites/g-api.adlithium.com/htdocs;
    
    keepalive_timeout 70;

    include white.list;

    location / {
        if ($request ~* https?://) { return 400; }

        proxy_set_header X-FORWARDED-PROTO https;
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
    }
}
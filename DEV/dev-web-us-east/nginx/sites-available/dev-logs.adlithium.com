
server {
    listen 80;
    listen [::]:80;

    server_name dev-logs.adlithium.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;

    server_name dev-logs.adlithium.com;

    # add Strict-Transport-Security to prevent man in the middle attacks
    add_header Strict-Transport-Security "max-age=31536000";
    
    location / {
	auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/.htpasswd;
	
	proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
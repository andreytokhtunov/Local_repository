server {
    listen 80;
    listen [::]:80;

    server_name dev-graphite.adlithium.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;

    server_name dev-graphite.adlithium.com;

    # add Strict-Transport-Security to prevent man in the middle attacks
    add_header Strict-Transport-Security "max-age=31536000";
    
    root /usr/share/graphite-web/;

    location / {
	auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/.htpasswd;
	include uwsgi_params;
	uwsgi_pass 127.0.0.1:3031;
    }
}
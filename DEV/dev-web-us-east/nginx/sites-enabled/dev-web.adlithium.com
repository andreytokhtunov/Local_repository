server {
    listen 80 default_server;
    listen [::]:80 default_server ipv6only=on;

    server_name dev-web.adlithium.com;

    rewrite     ^ https://$server_name$request_uri? permanent;
}


server {
    listen 443 default_server ssl;

    server_name dev-web.adlithium.com;
    root /home/skaag/sites/dev-web.adlithium.com/htdocs;
    
    keepalive_timeout 70;

    # For large files
    client_max_body_size 250M;

    location / {
	proxy_set_header X-FORWARDED-PROTO https;
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;

	#if ($request_method = 'GET') {
        #    add_header 'Access-Control-Allow-Origin' '*';
        #    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        #    add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        #}
	

	if ($request_method = 'OPTIONS') {
    	    add_header 'Access-Control-Allow-Origin' '*';
    	    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    	    add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
            add_header 'Access-Control-Max-Age' 1728000;
	    add_header 'Content-Type' 'text/plain charset=UTF-8';
            add_header 'Content-Length' 0;
	    return 204;
        }

         if ($request_method = 'POST') {
	    add_header 'Access-Control-Allow-Origin' '*';
    	    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
	    add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
    	    add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
        }

	if ($request_method = 'GET') {
    	    add_header 'Access-Control-Allow-Origin' '*';
    	    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    	    add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
    	    add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
        }
    }
    location /img {
        alias /home/skaag/img;
	
	if ($request_method = 'GET') {
    	    add_header 'Access-Control-Allow-Origin' '*';
    	    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    	    add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
    	    add_header 'Access-Control-Expose-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Content-Range,Range';
        }
    }
}


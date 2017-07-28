upstream backend_event_server {
    server 10.142.0.3:26001 max_fails=0 fail_timeout=10s;
    keepalive 512;

}
upstream backend_cs_server {
    server 10.142.0.3:15000 max_fails=0 fail_timeout=10s;
    keepalive 512;
}

# Supply sides backend servers.
upstream backend_bid_openx {
    server 10.142.0.3:12339 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_zedo {
    server 10.142.0.3:12350 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_adaptv {
    server 10.142.0.3:12351 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_smartyads {
    server 10.142.0.3:12352 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_google {
    server 10.142.0.3:12353 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_vertamedia {
    server 10.142.0.3:12354 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_epom {
    server 10.142.0.3:12355 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_smaato {
    server 10.142.0.3:12356 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_adforge {
    server 10.142.0.3:12357 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_mmg {
    server 10.142.0.3:12358 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_vrtcal {
    server 10.142.0.3:12359 max_fails=0 fail_timeout=10s;
    keepalive 512;
}
upstream backend_bid_wazimo {
    server 10.142.0.3:12360 max_fails=0 fail_timeout=10s;
    keepalive 512;
}

server {
    listen 10.142.0.3:80;
    server_name     dev-front-us-east.adlithium.com;
    root            /home/rtb/adm;
    index index.php;

    client_max_body_size 16M;

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires max; # changed here
        log_not_found off;
        tcp_nodelay off;
        open_file_cache max=1000 inactive=120s;
        open_file_cache_valid 45s;
        open_file_cache_min_uses 2;
        open_file_cache_errors off;
    }

    # Supply side redirections.
    location /bid/openx {
        proxy_pass http://backend_bid_openx/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/zedo {
        proxy_pass http://backend_bid_zedo/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/adaptv {
        proxy_pass http://backend_bid_adaptv/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/smartyads {
        proxy_pass http://backend_bid_smartyads/auctions;
        proxy_ignore_client_abort on;

        proxy_read_timeout 300;
        proxy_connect_timeout 300;

        proxy_http_version 1.1;
        proxy_set_header Connection "";

        keepalive_requests 500;
        keepalive_timeout 300;
    }

    location /bid/google {
        proxy_pass http://backend_bid_google/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/vertamedia {
        proxy_pass http://backend_bid_vertamedia/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/epom {
        proxy_pass http://backend_bid_epom/auctions;
        proxy_ignore_client_abort on;

        proxy_read_timeout 300;
        proxy_connect_timeout 300;

        proxy_http_version 1.1;
        proxy_set_header Connection "";
    }

    location /bid/smaato {
        proxy_pass http://backend_bid_smaato/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/adforge {
        proxy_pass http://backend_bid_adforge/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/mmg {
        proxy_pass http://backend_bid_mmg/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/vrtcal {
        proxy_pass http://backend_bid_vrtcal/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /bid/wazimo {
        proxy_pass http://backend_bid_wazimo/auctions;
        proxy_ignore_client_abort on;
        proxy_read_timeout 300;
    }

    location /cs/openx {
        expires max;
        try_files               $uri $uri/ /openx.cookies.sync.pixel.php$is_args$args;
    }

    location /cs/smartyads {
        expires max;
        try_files               $uri $uri/ /openx.cookies.sync.pixel.php$is_args$args;
    }

#    location /r {
#        expires max;
#        try_files               $uri $uri/ /runfile.php$is_args$args;
#    }

    location /cs {
        expires max;
        proxy_pass http://backend_cs_server/v1/putIds;
    }

    location /win {
        expires max;
        proxy_pass http://backend_event_server/v1/win;
    }

    location /tag {
        expires max;
        proxy_pass http://backend_event_server/v1/tag;
    }

    location /click {
        expires max;
        proxy_pass http://backend_event_server/v1/click;
    }

    location /timeonpage {
        proxy_pass http://backend_event_server/v1/timeonpage;
    }

    location /hover_start {
        proxy_pass http://backend_event_server/v1/hover_start;
    }

    location /hover_time {
        proxy_pass http://backend_event_server/v1/hover_time;
    }

    location /timeonpagetag {
        proxy_pass http://backend_event_server/v1/timeonpagetag;
    }

    location /ve {
        proxy_pass http://backend_event_server/v1/ve;
    }

    # For debug
    location /log {
        expires max;
        proxy_pass http://backend_event_server/v1/log;
    }
    
    location /log1 {
        expires max;
        proxy_pass http://backend_event_server/v1/log1;
    }

    location /log2 {
        expires max;
        proxy_pass http://backend_event_server/v1/log2;
    }

    location ~ \.php$ {
        include                 fastcgi_params;
        try_files               $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass_header     Host;
        fastcgi_pass_header     X-Real-IP;
        fastcgi_pass_header     X-Forwarded-For;
        fastcgi_pass            127.0.0.1:8000;
        fastcgi_index           index.php;
        fastcgi_param           SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        fastcgi_param           QUERY_STRING     $query_string;
    }
}

server {
    listen 10.142.0.3:443 ssl;
    server_name     dev-front-us-east.adlithium.com;
    root            /home/rtb/adm;
    index index.php;
    
    client_max_body_size 16M;

    add_header Strict-Transport-Security "max-age=0";

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires max; #
        log_not_found off;
        tcp_nodelay off;
        open_file_cache max=1000 inactive=120s;
        open_file_cache_valid 45s;
        open_file_cache_min_uses 2;
        open_file_cache_errors off;
    }

    location /win {
        expires max;
        proxy_pass http://backend_event_server/v1/win;
    }

    location /tag {
        expires max;
        proxy_pass http://backend_event_server/v1/tag;
    }
    
    location /click {
        expires max;
        proxy_pass http://backend_event_server/v1/click;
    }
        
    location /timeonpage {
        proxy_pass http://backend_event_server/v1/timeonpage;
    }
        
    location /hover_start {
        proxy_pass http://backend_event_server/v1/hover_start;
    }
        
    location /hover_time {
        proxy_pass http://backend_event_server/v1/hover_time;
    }
        
    location /timeonpagetag {
        proxy_pass http://backend_event_server/v1/timeonpagetag;
    }
        
    location /ve {
        proxy_pass http://backend_event_server/v1/ve;
    }

    # For debug
    location /log {
        expires max;
        proxy_pass http://backend_event_server/v1/log;
    }
    
    location /log1 {
        expires max;
        proxy_pass http://backend_event_server/v1/log1;
    }

    location /log2 {
        expires max;
        proxy_pass http://backend_event_server/v1/log2;
    }

    location ~ \.php$ {
        include                 fastcgi_params;
        try_files               $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass_header     Host;
        fastcgi_pass_header     X-Real-IP;
        fastcgi_pass_header     X-Forwarded-For;
        fastcgi_pass            127.0.0.1:8000;
        fastcgi_index           index.php;
        fastcgi_param           SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        fastcgi_param           QUERY_STRING     $query_string;
    }

}

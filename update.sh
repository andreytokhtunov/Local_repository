#!/bin/bash

DEV1='dev-web.adlithium.com'
REPO1='~/Desktop/Local_repository/DEV/dev-web-us-east'

#Update repo from DEV
cd ~/Desktop/Local_repository/DEV/dev-web-us-east
git pull
#scp -rp $DEV1:~/*.sh $REPO1
scp -rp skaag@$DEV1:~/sites $REPO1
#scp -rp $DEV1:/etc/nginx/* $REPO1/nginx
git add *
git commit -a -m "UPDATE DEV-WEB"
git push

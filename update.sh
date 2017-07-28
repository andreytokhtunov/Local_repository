#!/bin/bash

DEV1='dev-web.adlithium.com'
DEV2='dev-front-eu-west.adlithium.com'

#Update repo from DEV
cd ~/Desktop/Local_repository/DEV/dev-web-us-east
git pull
scp -rp skaag@$DEV1:~/*.sh $REPO1
scp -rp skaag@$DEV1:/etc/nginx/* ~/Desktop/Local_repository/DEV/dev-web-us-east/nginx
git add *
git commit -a -m "UPDATE DEV-WEB file"
git push

#Update repo from Fronts
cd ~/Desktop/Local_repository/DEV/dev-front-eu-west
git pull
scp -rp rtb@$DEV2:~/*.sh ~/Desktop/Local_repository/DEV/dev-front-eu-west
git add *
git commit -a -m "UPDATE Front file"
git push

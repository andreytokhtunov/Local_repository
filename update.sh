#!/bin/bash

DEV1='dev-web.adlithium.com'
DEV2='dev-front-eu-west.adlithium.com'
DEV3='dev-front-us-east.adlithium.com'

#Update repo from Dev-Web
cd ~/Desktop/Local_repository/DEV/dev-web-us-east
git pull
scp -rp skaag@$DEV1:~/*.sh ~/Desktop/Local_repository/DEV/dev-web-us-east/nginx
scp -rp skaag@$DEV1:/etc/nginx/* ~/Desktop/Local_repository/DEV/dev-web-us-east/nginx
git add *
git commit -m "UPDATE dev-web file `date`"
git push

#Update repo from Fronts
cd ~/Desktop/Local_repository/DEV/dev-front-eu-west
git pull
scp -rp rtb@$DEV2:~/*.sh ~/Desktop/Local_repository/DEV/dev-front-eu-west
scp -rp rtb@$DEV2:/etc/nginx/* ~/Desktop/Local_repository/DEV/dev-front-eu-west/nginx
git add *
git commit -a -m "UPDATE dev-front-eu-west file"
git push

cd ~/Desktop/Local_repository/DEV/dev-front-us-east
git pull
scp -rp rtb@$DEV3:~/*.sh ~/Desktop/Local_repository/DEV/dev-front-us-east
scp -rp rtb@$DEV3:/etc/nginx ~/Desktop/Local_repository/DEV/dev-front-us-east/nginx
git add *
git commit -a -m "UPDATE dev-front-us-east file"
git push

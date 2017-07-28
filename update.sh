#!/bin/bash

DEV1='dev-web.adlithium.com'
REPO1='~/Desktop/Local_repository/DEV/dev-web-us-east'

DEV2='dev-front-eu-west.adlithium.com'
REPO2='~/Desktop/Local_repository/DEV/dev-front-eu-west'

#Update repo from DEV
cd ~/Desktop/Local_repository/DEV/dev-web-us-east
git pull
scp -rp skaag@$DEV1:~/*.sh $REPO1
scp -rp skaag@$DEV1:/etc/nginx/* $REPO1/nginx
git add *
git commit -a -m "UPDATE DEV-WEB file"
git push

#Update repo from Fronts
cd ~/Desktop/Local_repository/DEV/dev-front-eu-west
git pull
scp -rp rtb@$DEV2:~/*.sh $REPO2
git add *
git commit -a -m "UPDATE Front file"
git push

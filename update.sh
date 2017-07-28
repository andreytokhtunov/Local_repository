#!/bin/bash

DEV1='dev-web.adlithium.com'

#Update repo from DEV
cd ~/Desktop/Local_repository/DEV/dev-web-us-east
git pull
scp -rp skaag@$DEV1:~/*.sh ~/Desktop/Local_repository/DEV/dev-web-us-east
git add *
git commit -a -m "UPDATE DEV-WEB"
git push

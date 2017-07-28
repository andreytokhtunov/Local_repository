#!/bin/bash

forever stopall
cd /home/skaag/sites/dev-web.adlithium.com/arbigo-web

export MONGO_URL='mongodb://adlithium:Athah5leBi9fe7ch@dev-db-us-east.adlithium.com:27017/lithiumdb'
export MONGO_OPLOG_URL='mongodb://adlithium:Athah5leBi9fe7ch@dev-db-us-east.adlithium.com:27017/local?authSource=lithiumdb'

echo "Run dev-web.adlithium.com in DEBUG mode."
meteor --settings settings-dev-us-east.json
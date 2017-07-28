#!/bin/bash
source $HOME/rtbkit-scripts/run/recepients.sh

BRANCH=dev

SUCCES_MSG='{ "attachments":[ { "color":"good", "title":"Api update", "title_link":"https://dev-api-us-east.adlithium.com/", '$RECEPIENTS', "text":"dev-api-us-east update completed.", "mrkdwn_in":[ "text" ], "fields":[ { "title":"Status", "value":"COMPLETED", "short":true }, { "title":"Host", "value":"dev-api-us-east.adlithium.com", "short":true }, { "title":"Branch", "value":"'$BRANCH'", "short":true } ] } ] }'
ERROR_MSG='{ "attachments":[ { "color":"danger", "title":"Api update", "title_link":"https://dev-api-us-east.adlithium.com/", '$RECEPIENTS', "text":"Update dev-api-us-east is failed.", "mrkdwn_in":[ "text" ], "fields":[ { "title":"Status", "value":"FAIL", "short":true }, { "title":"Host", "value":"dev-api-us-east.adlithium.com", "short":true }, { "title":"Branch", "value":"'$BRANCH'", "short":true } ] } ] }'
START_MSG='{ "attachments":[ { "color":"good", "title":"Api update", "title_link":"https://dev-api-us-east.adlithium.com/", '$RECEPIENTS', "text":"Start updating dev-api-us-east", "mrkdwn_in":[ "text" ], "fields":[ { "title":"Status", "value":"IN PROGRESS", "short":true }, { "title":"Host", "value":"dev-api-us-east.adlithium.com", "short":true }, { "title":"Branch", "value":"'$BRANCH'", "short":true } ] } ] }'

jarvis_say() {
    curl -X POST -H 'Content-type: application/json' \
    --data "$1" \
    https://hooks.slack.com/services/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
}

update_dev_api(){
    jarvis_say "$START_MSG"
    forever stopall

    cd /home/rtb/sites/g-api.adlithium.com/admin-api
    ./deploy-dev-us-east.sh $BRANCH

    sleep 10

    check=`sudo netstat -tulpn | grep node | grep -c 3001`
    echo $check
    if [ $check -ne 0 ];
    then
        jarvis_say "$SUCCES_MSG"
    else
        jarvis_say "$ERROR_MSG"
    fi
}

update_dev_api
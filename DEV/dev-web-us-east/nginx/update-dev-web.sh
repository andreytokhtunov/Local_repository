#!/bin/bash
source $HOME/rtbkit-scripts/run/recepients.sh

BRANCH=dev

SUCCES_MSG='{"attachments":[{"color":"good","title":"dev-web update","title_link":"https://dev-web.adlithium.com/",'$RECEPIENTS',"text":"dev-web update completed.","mrkdwn_in":["text"],"fields":[{"title":"Host","value":"dev-web.adlithium.com","short":true},{"title":"Branch","value": "'$BRANCH'","short":true}]}]}'
ERROR_MSG='{"attachments":[{"color":"danger","title":"dev-web update","title_link":"https://dev-web.adlithium.com/",'$RECEPIENTS',"text":"dev-web update failed.","mrkdwn_in":["text"],"fields":[{"title":"Host","value":"dev-web.adlithium.com","short":true},{"title":"Branch","value":"'$BRANCH'","short":true}]}]}'
START_MSG='{"attachments":[{"color":"good","title":"dev-web update","title_link":"https://dev-web.adlithium.com/",'$RECEPIENTS',"text":"dev-web is updating.","mrkdwn_in":["text"],"fields":[{"title":"Host","value":"dev-web.adlithium.com","short":true},{"title":"Branch","value": "'$BRANCH'","short":true}]}]}'

jarvis_say() {
    curl -X POST -H 'Content-type: application/json' \
    --data "$1" \
    https://hooks.slack.com/services/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
}

update_dev_web(){
  jarvis_say "$START_MSG"
  forever stopall

  cd /home/skaag/sites/dev-web.adlithium.com/arbigo-web
  ./deploy-dev-us-east.sh $BRANCH

  sleep 3
  echo ------------------------
  forever logs 0
  echo ------------------------

  sudo netstat -tulpn | grep 3000 | grep node &> /dev/null
  if [ $? == 0 ];
  then
      jarvis_say "$SUCCES_MSG"
  else
      jarvis_say "$ERROR_MSG"
  fi
}

update_dev_web

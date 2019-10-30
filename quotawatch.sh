#!/bin/bash
#Written by sysvinit#4853
#Script to monitor quotas
#make sure to chmod +x this script 

#Set your limit to stop autosnatch, This will trigger once you hit a certian amount space used, So if the limit is 1800 then it will stop at 1800G used.
quotalimit="840"
#Discord Webhook URL
discordwebhook="https://discordapp.com/api/webhooks/"
#Set location of curl
curl="/usr/local/bin/curl"

#Only Modify if you know what you are doing
quotaleft=$(quota -s | awk 'FNR == 3 {print ($2)-1+1}')

#Safety Net Lock File, Will remove once the script can verify if autosnatchers are running
if (( $quotaleft < $quotalimit )) ; then
    rm -f lock
elif [ -e "lock" ]; then
    exit
elif (( $quotaleft > $quotalimit )) ; then
    echo '.' >> lock
    ps -ef | grep "setprogramhere" | grep -v grep | awk '{print $2}' | xargs kill
    #Enable if you want to log to file on disk and not discord. Make sure to comment out discord if not used. 
    #echo "Your quota limit $quotalimit was reached and I have disabled autosnatching" >> log
    $curl -H "Content-Type: application/json" \
        -X POST \
        -d '{
        "embeds": [{
        "title": "Autosnatch Disabled!",
        "description": "Your autosnatchers have been disabled due to the disk being full."
        }]
        }' $discordwebhook
else
    exit
fi

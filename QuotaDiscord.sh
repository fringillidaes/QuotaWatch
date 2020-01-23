#!/bin/bash
#Written by https://github.com/fringillidaes
#Script to monitor quotas
#make sure to chmod +x this script
#reference https://raw.githubusercontent.com/no5tyle/UltraSeedbox-Scripts/master/MergerFS-Rclone/Upload%20Scripts/rclone-upload-with-notification.sh

#ALL MEASUREMENTS ARE DONE IN GB

#Set notification alert threshold IN GB
alertlimit=""
#Discord Webhook URL
discordwebhook=""
#Set location of curl
curl="/usr/local/bin/curl" 
#Webhook Settings
username=""
image=""

#Only modify below if you know what you are doing
quotaused=$(quota -s | awk 'FNR == 3 {print ($2)-1+1}')
disksize=$(quota -s | awk 'FNR == 3 {print ($3)-1+1}')
diskleft=$(expr $disksize - $quotaused)

if (( $quotaused < $alertlimit )) ; then
    exit
elif (( $quotaused > $alertlimit )) ; then
messageformat='{
        "username": "'"$username"'",
        "avatar_url": "'"$image"'",
        "content": null,
        "embeds": [
          {
            "title": "Disk is about to be full! :rage:",
            "color": 2456666,
            "fields": [
              {
                "name": "Disk Size",
                "value": "'"$disksize GB"'"
              },
              {
                "name": "Disk Limit Setting",
                "value": "'"$alertlimit GB"'"
              },
              {
                "name": "Current Disk Space Used",
                "value": "'"$quotaused GB"'"
              },
              {
                "name": "Current Disk Space Left",
                "value": "'"$diskleft GB"'"
              }
            ],
            "thumbnail": {
              "url": null
            }
          }
        ]
      }'
    curl -H "Content-Type: application/json" -d "$messageformat" $discordwebhook
    exit
fi

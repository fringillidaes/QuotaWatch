# QuotaDiscord
Have your seedbox send a notification when its disk gets low. Utilizes the quota command to read space.

Move to whatever dir you want the script in, for example mines ~/scripts

Download the script using wget,

```
wget https://raw.githubusercontent.com/fringillidaes/QuotaWatch/master/QuotaDiscord.sh 
````
Modify the following lines,

```
alertlimit="840" #Set the alert point, If set to 1000GB it will trigger here.

discordwebhook="https://discordapp.com/api/webhooks/696969669696" #Set discord webhook

curl="/usr/local/bin/curl" #Set location for curl, can be found by running which curl

username="USB-JAG DISK" #Set webhook username, usefull for identifying what box is full

image="https://i.imgur.com/PCUW7F5.png" #image for webhook
```
Make the script executable.

```
chmod +x QuotaDiscord.sh 
```
Add to crontab,
(Can use a generator, https://crontab-generator.org/)

```
crontab -e

#paste the generated crontab or format this one (for every 5 minutes to send)
*/5 * * * * /home/username/DiscordQuotas.sh >/dev/null 2>&1

#mine for usb
*/5 * * * * /homeXX/username/DiscordQuotas.sh >/dev/null 2>&1
```

# QuotaWatch (Under revision)
Have your auto-snatching programs automatically stop when disk space is full on shared seedbox providers.

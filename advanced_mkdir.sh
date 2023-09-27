#!/bin/bash
#author:gayathridevi.s@keyvalue.systems

function send_alert(){
	alert_username=$1
	alert_filename=$2
	alert_ip=$3
	curl -s -X POST --data-urlencode "payload={   \"text\": \"the user with username $alert_username is trying to create a directory $alert_filename from the ip address $alert_ip\"}" https://hooks.slack.com/services/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 > /dev/null
}
filename=$1
word="kvops"
location=`pwd`
if [[ $location  == "/home/gayathri/Desktop/kvops"  || $location == "/home/gayathri/Desktop/kvops/"* ]]
then
if [[ $filename = $word* ]]
then 
mkdir $filename
mv $filename $filename$(date +"%d-%m-%Y")
green='\033[0;32m'
echo -e "${green}Successfully created a directory "
else
red='\033[0;31m'
echo -e "${red}Not able to create a directory"
ip=`curl -s ifconfig.me`
username=`whoami`
send_alert $username $filename $ip
fi
else 
	mkdir $filename
fi

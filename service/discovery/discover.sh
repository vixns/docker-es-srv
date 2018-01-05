#!/bin/sh

dnssrv() {

	IFS=$'
	'
	res=''

	for entry in $(dig $NS +short srv $DISCOVER_HOSTNAME | awk '{print $NF}')
	do
	  ip=$(dig $NS srv +noanswer $DISCOVER_HOSTNAME | grep "$entry" | awk '{print $NF}')
	  res="${res}${ip}\n"
	done
	if [ -n "$res" ]
	then
		IPS=$(echo -e ${res%"\n"} | sort)
	else
		exit 1
	fi
}

while true
do
dnssrv
IFS=''
echo $IPS > $DISCOVER_FILE
sleep $DISCOVERY_FREQ_SECONDS
done

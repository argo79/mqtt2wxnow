#!/bin/bash
#
# SCRITTO DA ME, ARG0, PER USARE I DATI IN MQTT E SALVARLI IN WXNOW.TXT PER DIREWOLF E APRS
# Questo script viene eseguito all'interno di Mqtt-sequenziale.sh, attiva le sottoscrizioni al broker e salva il timestamp e il payload di ogni topic in singoli files
##########################################################################################


#press=0
#temp=0
#umi=0
broker_ip="*.*.*.*"    # indirizzo ip del broker

dir="~/mqtt2wxnow"

while true
do
	while read -r payloadT
	do
	today=$(/bin/date "+%Y-%m-%d+%H-%M-%S")    #Used to generate filename
	temp=$payloadT
	valori[0]=$temp
	echo -n $today > $dir/temp.txt
	echo " T:"$temp >> $dir/temp.txt
	#echo "T:"$temp

	#today=$(/bin/date "+%Y-%m-%d+%H-%M-%S")    #Used to generate filename
	#echo $today
	done <<<$(mosquitto_sub -h $broker_ip -C 1 -t "sonda/esp32/giardino/Temperatura") &

	while read -r payloadP
	do	
	today=$(/bin/date "+%Y-%m-%d+%H-%M-%S")    #Used to generate filename
	press=$payloadP
	valori[1]=$press
	echo -n $today > $dir/press.txt
	echo " P:"$press >> $dir/press.txt
	#echo "P:"$press
	done <<<$(mosquitto_sub -h $broker_ip -C 1 -t "sonda/esp32/giardino/Pressione") &
	
	while read -r payloadU
	do
	today=$(/bin/date "+%Y-%m-%d+%H-%M-%S")    #Used to generate filename
	umi=$payloadU
	valori[2]=$umi
	#echo ${valori[2]}
	echo -n $today > $dir/umi.txt
	echo " U:"$umi >> $dir/umi.txt
	#echo "U:"$umi

	#echo -n ${valori[1]}
	#echo -n ${valori[0]}

	done <<<$(mosquitto_sub -h $broker_ip -C 1 -t "sonda/esp32/giardino/Umidita") 
	
	

	#today=$(/bin/date "+%Y-%m-%d+%H-%M-%S")    #Used to generate filename
    #echo $today > $dir/today.txt	
    #echo $today
	
	
	
	# echo -n "	" >> $dir/today.txt
	
	# echo -n "	" >> $dir/today.txt
	
	# echo -n "	" >> $dir/today.txt
	
done
exit 0

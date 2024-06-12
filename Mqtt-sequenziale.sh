#! /bin/bash
broker_ip="192.168.1.11"
valori=()

dir="/home/kevin/blobspace/mqtt2wxnow"

$dir/./Mqtt2prova.sh &

sleep 15

temp=$(<$dir/temp.txt)
press=$(<$dir/press.txt)
umi=$(<$dir/umi.txt)

valori[0]=$temp
valori[1]=$press
valori[2]=$umi


IFS=':' read -a data <<< "${valori[0]}"
timeT=${data[0]}
tempC=${data[1]}
echo $timeT
echo $tempC
tempF=$(echo "scale=1; $tempC*1.8+32" | bc -l)
tempFA=${tempF%%.*}
echo $tempF
#echo $tempFA


IFS=':' read -a data <<< "${valori[1]}"
timeP=${data[0]}
press=${data[1]}
echo $timeP
echo $press
pressM=$(echo "scale=0; $press * 10" | bc -l)
pressA=${pressM%%.*}


IFS=':' read -a data <<< "${valori[2]}"
timeU=${data[0]}
umi=${data[1]}
echo $timeU
echo $umi
umiA=${umi%%.*}

if [[ $tempFF -lt 100 ]]
then
	inizio=".../...g...t0"
else
	inizio=".../...g...t"
fi


today=$(/bin/date "+%b %d %Y %H:%M")    #Used to generate filename
echo ${today^}
echo ${today^} > $dir/wxnow.txt
msg=$(echo $inizio$tempFA"r...p...P...h"$umiA"b"$pressA)
echo $msg
echo $msg >> $dir/wxnow.txt

sleep 5
killall -9 Mqtt2prova.sh
sleep 5
killall -9 mosquitto_sub
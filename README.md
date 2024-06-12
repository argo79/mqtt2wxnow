# MQTT to WXNOW.TXT

Doppio script:

Mqtt2wxnow.sh può essere inserito in crontab,

lancia MqttSub.sh che sottoscrive diversi topic in un broker (salva timestamp e payload in sigoli files),

poi prosegue creando il file wxnow.txt pronto per Direwolf e APRS.

#

Formato MQTT :

home/stanza/oggetto/temperatura 21.7 oppure sonda/esterno/nord/pressione 1013.3

#

Formato WX per APRS :

Jun 01 2003 08:07

272/000g006t069r010p030P020h61b10133

#

# MQTT ----------> MosquittoBroker --------->    WXNOW.TXT

# esp32     Mqtt2prova + Mqtt-sequenziale        Direwolf

Arg0net 2024

IU3IOK-1 on https://aprs.fi/info/a/IU3IOK-1

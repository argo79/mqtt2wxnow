# MQTT to WXNOW.TXT

Doppio script:

Mqtt-sequenziale.sh può essere inserito in crontab,

lancia Mqtt2prova.sh che sottoscrive diversi topic in un broker (salva timestamp e payload in sigoli files),

poi prosegue creando il file wxnow.txt pronto per Direwolf e APRS.

#

Formato MQTT :

home/stanza/oggetto/temperatura payload oppure sonda/esterno/nord/pressione payload

#

Formato WX per APRS :

Jun 01 2003 08:07

272/000g006t069r010p030P020h61b10150

#

# MQTT ----------> MosquittoBroker --------->    WXNOW.TXT

# esp32     Mqtt2prova + Mqtt-sequenziale        Direwolf

Arg0net 2024

IU3IOK-1 on https://aprs.fi/info/a/IU3IOK-1

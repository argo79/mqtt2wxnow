# MQTT to WXNOW.TXT

Doppio script:

Mqtt-sequenziale.sh può essere inserito in crontab,

lancia Mqtt2prova.sh che sottoscrive diversi topic in un broker (salva timestamp e payload in sigoli files),

poi prosegue creando il file wxnow.txt pronto per Direwolf e APRS.

# MQTT ----------> MosquittoBroker --------->    WXNOW.TXT

# esp32     Mqtt2prova + Mqtt-sequenziale        Direwolf

Arg0net 2024

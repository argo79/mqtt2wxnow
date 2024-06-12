# python 3.11
import random
import os.path

from datetime import datetime
from paho.mqtt import client as mqtt_client

save_path = '~/mqtt2wxnow'

temp=0
tempF=0
umi=0
press=0
wxnowFile = "wxnow.txt"

broker = '192.168.1.11'
port = 1883
topicT = "sonda/esp32/giardino/Temperatura"
topicP = "sonda/esp32/giardino/Pressione"
topicU = "sonda/esp32/giardino/Umidita"
# Generate a Client ID with the subscribe prefix.
client_id = f'subscribe-{random.randint(0, 100)}'
# username = 'emqx'
# password = 'public'


def connect_mqtt() -> mqtt_client:
    def on_connect(client, userdata, flags, rc):
        if rc == 0:
            print("Connected to MQTT Broker!")
        else:
            print("Failed to connect, return code %d\n", rc)

    client = mqtt_client.Client(client_id)
    # client.username_pw_set(username, password)
    client.on_connect = on_connect
    client.connect(broker, port)
    return client


def subscribe(client: mqtt_client):
    def on_message(client, userdata, msg):
        #print(f"Received '{msg.payload.decode()}' from '{msg.topic}' topic")
        
        global temp, tempF, press, umi

        if msg.topic==topicT:
            temp=float(msg.payload)
            tempF=int(round(temp*1.8+32))
            #print(temp)
            #print(tempF)
        if msg.topic==topicP:
            press=float(msg.payload)
            press=int(round(press*10))
            #print(press)
        if msg.topic==topicU:
            umi=float(msg.payload)
            #print(umi)            
            umi=int(round(umi))
            #print(umi)
        
        if tempF !=0 and press !=0 and umi != 0 :
            if tempF < 100 :
                wxnow=".../...g...t0"+str(tempF)+"r...p...P...h"
            else :
                wxnow=".../...g...t"+str(tempF)+"r...p...P...h"
            
            #wxnow2=wxnow+"r...p...P...h"
            wxnow3=wxnow+str(umi)+"b"+str(press)+""                      
            
            now = datetime.now()            
            dataWX = now.strftime("%b %d %Y %H:%M")
            print(dataWX)
            print(wxnow3)
            
            file1 = open(fileName, "a")
            toFile =(dataWX)
            file1.write(dataWX+"\n")
            toFile =(wxnow3)            
            file1.write(toFile+"\n")
            file1.close()

            tempF=0
            temp=0
            press=0
            umi=0



    client.subscribe(topicT)
    client.subscribe(topicP)
    client.subscribe(topicU)
    client.on_message = on_message

def run():
    global fileName
    fileName=os.path.join(save_path,wxnowFile)

    client = connect_mqtt()
    subscribe(client)
    
    client.loop_forever()


if __name__ == '__main__':
    run()


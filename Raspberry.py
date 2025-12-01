
import serial
import time
from grove_rgb_lcd import * # Bibliothèque de l'écran

# Configuration des ports (A adapter selon les branchements USB/GPIO)
# Port entrant (Arduino Gauche)
ser_in = serial.Serial('/dev/ttyACM0', 9600, timeout=1)
# Port sortant (Vers Arduino Droite via GPIO TX)
ser_out = serial.Serial('/dev/ttyAMA0', 9600, timeout=1)

def update_lcd(r_state, v_state):
    setText("Rouge: " + r_state + "\nVert: " + v_state)
    # On peut changer la couleur de fond aussi (ex: setRGB(0, 255, 0))

while True:
    if ser_in.in_waiting > 0:
        # Lecture et décodage du caractère
        data = ser_in.read().decode('utf-8')
        
        # Logique de traitement
        if data == 'R':
            update_lcd("ON ", "OFF")
            ser_out.write(b'R') # Relais de la commande
        elif data == 'V':
            update_lcd("OFF", "ON ")
            ser_out.write(b'V')
        elif data == 'D':
            update_lcd("ON ", "ON ")
            ser_out.write(b'D')
        else: # Cas '0'
            update_lcd("OFF", "OFF")
            ser_out.write(b'0')
            
        time.sleep(0.1)



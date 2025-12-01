
#include <SoftwareSerial.h>

// Configuration SoftwareSerial : RX = Pin 10, TX = Pin 11
// Le paramètre "true" active l'INVERSION LOGIQUE pour compenser le transistor
SoftwareSerial mySerial(10, 11, true);

const int ledRouge = 5;
const int ledVert = 6;

void setup() {
  pinMode(ledRouge, OUTPUT);
  pinMode(ledVert, OUTPUT);
  
  // Démarrage de la liaison série logicielle
  mySerial.begin(9600);
}

void loop() {
  if (mySerial.available()) {
    char c = mySerial.read();
    
    // Exécution des ordres
    if (c == 'R') {
      digitalWrite(ledRouge, HIGH);
      digitalWrite(ledVert, LOW);
    } 
    else if (c == 'V') {
      digitalWrite(ledRouge, LOW);
      digitalWrite(ledVert, HIGH);
    }
    else if (c == 'D') {
      digitalWrite(ledRouge, HIGH);
      digitalWrite(ledVert, HIGH);
    }
    else if (c == '0') {
      digitalWrite(ledRouge, LOW);
      digitalWrite(ledVert, LOW);
    }
  }
}

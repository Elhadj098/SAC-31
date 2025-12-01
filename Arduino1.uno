

// Arduino Emetteur
const int btnRouge = 2;
const int btnVert = 3;

void setup() {
  Serial.begin(9600); // Initialisation port série
  // Utilisation des résistances internes pour éviter les courts-circuits
  pinMode(btnRouge, INPUT_PULLUP);
  pinMode(btnVert, INPUT_PULLUP);
}

void loop() {
  // Lecture inversée car INPUT_PULLUP (Appuyé = LOW)
  bool rougeAppuye = (digitalRead(btnRouge) == LOW);
  bool vertAppuye = (digitalRead(btnVert) == LOW);

  if (rougeAppuye && vertAppuye) {
    Serial.print('D'); // Double
  } else if (rougeAppuye) {
    Serial.print('R'); // Rouge
  } else if (vertAppuye) {
    Serial.print('V'); // Vert
  } else {
    Serial.print('0'); // Rien
  }
  
  delay(100); // Petit délai pour stabiliser la communication
}
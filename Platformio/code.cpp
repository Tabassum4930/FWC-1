#include <Arduino.h>
const int xPin = 2;    // pin initialisatons   
const int yPin = 3;   
const int qPin = 4;       
const int nqPin = 7;     
const int dPin = 5;       
const int clkPin = 6;     
const int ledPin = 8;     

void setup() {
	// Set pin modes
  pinMode(xPin, INPUT);
  pinMode(yPin, INPUT);
  pinMode(qPin, INPUT);    
  pinMode(nqPin, INPUT);   
  pinMode(dPin, OUTPUT);
  pinMode(clkPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
// initialize clock to LOW
  digitalWrite(clkPin, LOW);
}

void loop() {
	// read inputs
  bool X = digitalRead(xPin);
  bool Y = digitalRead(yPin);
  bool Q = digitalRead(qPin); // read Q from the 7474 ouput pin 
  // claculate S = X ⊕ Y ⊕ Q; 
  bool S = X ^ Y ^ Q;
 // set the D input of FF
 digitalWrite(dPin, S);
// generating clock pulse
  digitalWrite(clkPin, HIGH);   
  delay(1000);                  
  digitalWrite(clkPin, LOW);   
  delay(1000);
  // display the state of Q using the LED
  digitalWrite(ledPin, Q);      
}


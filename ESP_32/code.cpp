//LCD diplay through OTA
#include <WiFi.h>
#include <WiFiUdp.h>
#include <ArduinoOTA.h>
#include <LiquidCrystal.h>
//    Can be client or even host   //
#ifndef STASSID
#define STASSID "gvv"  // Replace with your network credentials
#define STAPSK  "password2"  
#endif
LiquidCrystal lcd(19, 23, 18, 17, 16, 15);
const char* ssid = "vivo v2109";
const char* password = "53762351";

void OTAsetup() {
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  while (WiFi.waitForConnectResult() != WL_CONNECTED) {
    delay(5000);
    ESP.restart();
  }
  ArduinoOTA.begin();
}

void OTAloop() {
  ArduinoOTA.handle();
}

void setup(){
  OTAsetup();
    lcd.begin(16, 2);
}

void loop() {
  OTAloop();
  delay(10);  // If no custom loop code ensure to have a delay in loop
lcd.setCursor(0, 0);
  // Print a message to the LCD.
  lcd.print("Encoded Sequence");
  lcd.setCursor(0, 1);
  lcd.print("1110101011100");  
}

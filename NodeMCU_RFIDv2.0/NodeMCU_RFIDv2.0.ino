//*******************************libraries********************************
// RFID-----------------------------
#include <SPI.h>
#include <MFRC522.h>
// NodeMCU--------------------------
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
//************************************************************************
// D2   sda/ss
// d5   sck
// d7   mosi
// d6   miso
// gnd  gnd
// d1   rst
// 3v    3.3v

// LED1   D3
// LED2   D4
// LED3   D8
//************************************************************************

#define SS_PIN D2   //
#define RST_PIN D1  //
#define LED1_PIN D3
#define LED2_PIN D4
#define LED3_PIN D8

bool led1State = true;  // Initial state of LED1
bool led2State = true;  // Initial state of LED2
bool led3State = true;  // Initial state of LED3

//************************************************************************
MFRC522 mfrc522(SS_PIN, RST_PIN);  // Create MFRC522 instance.
//************************************************************************
/* Set these to your desired credentials. */
const char *ssid = "Raj";
const char *password = "12345678";
const char *device_token = "f0d27163a1cae5f3";
//************************************************************************
String URL = "http://192.168.52.29/AC-Controller/getdata.php";  // computer IP or the server domain
String getData, Link;
String OldCardID = "";
unsigned long previousMillis = 0;
//************************************************************************


//************************************************************************
void setup() {
  delay(1000);

  Serial.begin(115200);

  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
  pinMode(LED3_PIN, OUTPUT);

  digitalWrite(LED1_PIN, HIGH);
  digitalWrite(LED2_PIN, HIGH);
  digitalWrite(LED3_PIN, HIGH);

  connectToWiFi();
  SPI.begin();         // Init SPI bus
  mfrc522.PCD_Init();  // Init MFRC522 card
  //---------------------------------------------
}
//************************************************************************
void loop() {
  // check if there's a connection to Wi-Fi or not
  if (!WiFi.isConnected()) {
    connectToWiFi();  // Retry to connect to Wi-Fi
  }
  //---------------------------------------------
  if (millis() - previousMillis >= 15000) {
    previousMillis = millis();
    OldCardID = "";
  }
  delay(50);
  //---------------------------------------------
  // look for new card
  if (!mfrc522.PICC_IsNewCardPresent()) {
    return;  // go to start of loop if there is no card present
  }
  // Select one of the cards
  if (!mfrc522.PICC_ReadCardSerial()) {
    return;  // if read card serial(0) returns 1, the uid struct contains the ID of the read card.
  }
  String CardID = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    CardID += mfrc522.uid.uidByte[i];
  }
  //---------------------------------------------
  if (CardID == OldCardID) {
    return;
  } else {
    OldCardID = CardID;
  }
  //---------------------------------------------
  SendCardID(CardID);
  delay(1000);
}
//************send the Card UID to the website*************
void SendCardID(String Card_uid) {
  Serial.println("Sending the Card ID");
  if (WiFi.isConnected()) {
    HTTPClient http;  // Declare object of class HTTPClient
    WiFiClient client;
    // GET Data
    getData = "?card_uid=" + String(Card_uid) + "&device_token=" + String(device_token);  // Add the Card ID to the GET array in order to send it
    // GET method
    Link = URL + getData;
    http.begin(client, Link);  // initiate HTTP request   //Specify content-type header

    int httpCode = http.GET();          // Send the request
    String payload = http.getString();  // Get the response payload

    Serial.println(httpCode);  // Print HTTP return code
    Serial.println(Card_uid);  // Print Card ID
    Serial.println(payload);   // Print request response payload

    if (httpCode == 200) {
      if (payload.substring(0, 5) == "login") {
        String user_name = payload.substring(5);
        Serial.println(user_name);

        led1State = !led1State;
        digitalWrite(LED1_PIN, led1State ? HIGH : LOW);
        Serial.print("LED1 State: ");
        Serial.println(led1State ? "ON" : "OFF");

        led2State = !led2State;
        digitalWrite(LED2_PIN, led2State ? HIGH : LOW);
        Serial.print("LED2 State: ");
        Serial.println(led2State ? "ON" : "OFF");

        led3State = !led3State;
        digitalWrite(LED3_PIN, led3State ? HIGH : LOW);
        Serial.print("LED3 State: ");
        Serial.println(led3State ? "ON" : "OFF");

      } else if (payload.substring(0, 6) == "logout") {
        String user_name = payload.substring(6);
        Serial.println(user_name);

        led1State = !led1State;
        digitalWrite(LED1_PIN, led1State ? HIGH : LOW);
        Serial.print("LED1 State: ");
        Serial.println(led1State ? "ON" : "OFF");

        led2State = !led2State;
        digitalWrite(LED2_PIN, led2State ? HIGH : LOW);
        Serial.print("LED2 State: ");
        Serial.println(led2State ? "ON" : "OFF");

        led3State = !led3State;
        digitalWrite(LED3_PIN, led3State ? HIGH : LOW);
        Serial.print("LED3 State: ");
        Serial.println(led3State ? "ON" : "OFF");


      } else if (payload == "successful") {
      } else if (payload == "available") {
      }

      delay(100);
      http.end();  // Close connection
    }
  }
}
//********************connect to the WiFi******************
void connectToWiFi() {
  WiFi.mode(WIFI_OFF);  // Prevents reconnection issue (taking too long to connect)
  delay(1000);
  WiFi.mode(WIFI_STA);
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("Connected");

  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());  // IP address assigned to your ESP

  delay(1000);
}
//=======================================================================

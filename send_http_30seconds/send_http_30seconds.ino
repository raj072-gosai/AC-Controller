#include <SPI.h>
#include <MFRC522.h>
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

// Pin definitions
#define SS_PIN D2    // RFID SS pin
#define RST_PIN D1   // RFID RST pin
#define LED1_PIN D3  // LED1 pin
#define LED2_PIN D4  // LED2 pin
#define LED3_PIN D8  // LED3 pin

// Initial LED states
bool led1State = true;  // Initial state of LED1
bool led2State = true;  // Initial state of LED2
bool led3State = true;  // Initial state of LED3

// Create MFRC522 instance
MFRC522 mfrc522(SS_PIN, RST_PIN);

// WiFi credentials and device token
const char *ssid = "Raj";
const char *password = "12345678";
const char *device_token = "f0d27163a1cae5f3";

// URLs for the server
String loginURL = "http://192.168.128.29/AC-Controller/getdata.php";
String keepAliveURL = "http://192.168.128.29/AC-Controller/user.php";
String getData, Link;
String OldCardID = "";         // To track the previous card ID
String currentCardID = "";     // To track the currently logged-in card ID
String loggedInUserName = "";  // To track the username of the logged-in user

// Timing variables for periodic tasks
unsigned long previousMillis = 0;
unsigned long lastSendMillis = 0;
const long interval = 30000;  // Interval to send HTTP requests (30 seconds)

// Setup function
void setup() {
  delay(1000);
  Serial.begin(115200);

  // Initialize LED pins
  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
  pinMode(LED3_PIN, OUTPUT);

  // Set initial state of LEDs to HIGH (OFF)
  digitalWrite(LED1_PIN, HIGH);
  digitalWrite(LED2_PIN, HIGH);
  digitalWrite(LED3_PIN, HIGH);

  // Connect to Wi-Fi
  connectToWiFi();

  // Initialize SPI bus and MFRC522 card reader
  SPI.begin();
  mfrc522.PCD_Init();
}

// Main loop
void loop() {
  unsigned long currentMillis = millis();

  // Reconnect to Wi-Fi if disconnected
  if (!WiFi.isConnected()) {
    connectToWiFi();
  }

  // Periodically send logged-in user data
  if (currentMillis - lastSendMillis >= interval && currentCardID != "") {
    lastSendMillis = currentMillis;
    SendLoggedInUser();
  }

  // Clear OldCardID every 15 seconds to allow re-scanning of the same card after this period
  if (currentMillis - previousMillis >= 15000) {
    previousMillis = currentMillis;
    OldCardID = "";
  }

  delay(50);  // Small delay to prevent overwhelming the loop

  // Check if a new card is present
  if (!mfrc522.PICC_IsNewCardPresent()) {
    return;
  }

  // Read the card serial number
  if (!mfrc522.PICC_ReadCardSerial()) {
    return;
  }

  // Construct CardID from the card's UID
  String CardID = "";
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    CardID += String(mfrc522.uid.uidByte[i], HEX);
  }

  // Skip if the same card as before is scanned within 15 seconds
  if (CardID == OldCardID) {
    return;
  } else {
    OldCardID = CardID;
  }

  // Logout if the same card is tapped again, otherwise login
  if (CardID == currentCardID) {
    logoutUser();
    delay(1000);
  } else if (currentCardID == "") {
    SendCardID(CardID);
    delay(1000);
  }
}

// Send the Card UID to the server for login
void SendCardID(String Card_uid) {
  Serial.println("Sending the Card ID");
  if (WiFi.isConnected()) {
    HTTPClient http;
    WiFiClient client;

    // Construct GET request URL
    getData = "?card_uid=" + String(Card_uid) + "&device_token=" + String(device_token);
    Link = loginURL + getData;
    http.begin(client, Link);

    int httpCode = http.GET();          // Send the request
    String payload = http.getString();  // Get the response payload

    Serial.println(httpCode);
    Serial.println(Card_uid);

    Serial.println("==========================================");
    Serial.println(loginURL);
    Serial.println(Link);
    Serial.println(getData);
    Serial.println(payload);
    Serial.println("==========================================");

    // Handle server response
    if (httpCode == 200) {
      if (payload.startsWith("login")) {
        String user_name = payload.substring(5);
        Serial.println(user_name);

        toggleLEDs();  // Toggle LEDs to indicate login

        currentCardID = Card_uid;      // Update current card ID
        loggedInUserName = user_name;  // Store the username of the logged-in user
      }
    } else {
      Serial.print("Error in HTTP request: ");
      Serial.println(httpCode);
    }
    delay(100);
    http.end();  // Close connection
  }
}

// Send a logout request for the current user
void logoutUser() {
  Serial.println("Logging out the current user");
  if (WiFi.isConnected()) {
    HTTPClient http;
    WiFiClient client;

    // Construct GET request URL with logout parameter
    getData = "?card_uid=" + String(currentCardID) + "&device_token=" + String(device_token) + "&logout=true";
    Link = loginURL + getData;
    http.begin(client, Link);

    int httpCode = http.GET();          // Send the request
    String payload = http.getString();  // Get the response payload

    Serial.println(httpCode);
    Serial.println(currentCardID);
    Serial.println(payload);

    // Handle server response
    if (httpCode == 200) {
      if (payload.startsWith("logout")) {
        String user_name = payload.substring(6);
        Serial.println(user_name);

        toggleLEDs();  // Toggle LEDs to indicate logout

        currentCardID = "";     // Clear current card ID
        loggedInUserName = "";  // Clear logged-in username
      }
    } else {
      Serial.print("Error in HTTP request: ");
      Serial.println(httpCode);
    }
    delay(100);
    http.end();  // Close connection
  }
}

// Periodically send logged-in user data to the server
void SendLoggedInUser() {
  if (WiFi.isConnected()) {
    HTTPClient http;
    WiFiClient client;

    // Construct GET request URL
    getData = "?card_uid=" + String(currentCardID) + "&device_token=" + String(device_token);
    Link = keepAliveURL + getData;
    http.begin(client, Link);

    int httpCode = http.GET();          // Send the request
    String payload = http.getString();  // Get the response payload

    Serial.println(httpCode);
    Serial.println(loggedInUserName);
    Serial.println(keepAliveURL);
    Serial.println(Link);
    Serial.println(getData);
    Serial.println("============================================");
    Serial.println(payload);


    delay(100);
    http.end();  // Close connection
  }
}

// Connect to Wi-Fi
void connectToWiFi() {
  WiFi.mode(WIFI_OFF);  // Prevents reconnection issue
  delay(1000);
  WiFi.mode(WIFI_STA);
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  // Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("Connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  delay(1000);
}

// Toggle the state of the LEDs
void toggleLEDs() {
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
}

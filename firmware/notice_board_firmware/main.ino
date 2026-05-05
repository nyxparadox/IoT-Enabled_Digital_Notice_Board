//                    --------- NOTICE ---------

// If you open this firmware code in VS Code, you may see errors like:
// fatal error: Firebase_ESP_Client.h: No such file or directory

// This is expected.

// --- WHY THIS HAPPENS
// This project is built using **Arduino IDE**, where libraries like:
// * Firebase ESP Client
// * ESP32 HUB75 Matrix Panel
// are managed automatically.
// VS Code (without PlatformIO or Arduino extension setup) cannot resolve these libraries, so it shows false errors.

// ---- IMPORTANT
// * These are editor-only errors
// * The code compiles and runs correctly in Arduino IDE

// ----- HOW YOU CAN FIX (OPTIONAL)
// If you want proper IntelliSense in VS Code:
// * Install Arduino extension OR PlatformIO
// * Configure ESP32 board and libraries
// Otherwise, you can safely ignore these warnings.




#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <ESP32-HUB75-MatrixPanel-I2S-DMA.h>

// WIFI
// ==========================
const char *ssid = "wifi_name";
const char *password = "Wifi_password";

// FIREBASE
// ==========================
#define API_KEY "your_database_appi_key"
#define DATABASE_URL "https://---your_databse_url---/"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// PANEL CONFIG
// ==========================
#define PANEL_RES_X 80
#define PANEL_RES_Y 40
#define PANEL_CHAIN 1

#define R1_PIN 25
#define G1_PIN 26
#define B1_PIN 27
#define R2_PIN 14
#define G2_PIN 12
#define B2_PIN 13
#define A_PIN 23
#define B_PIN 19
#define C_PIN 5
#define D_PIN 2
#define E_PIN 15
#define LAT_PIN 4
#define OE_PIN 16
#define CLK_PIN 18

MatrixPanel_I2S_DMA *dma_display = nullptr;

// DATA VARIABLES
// ==========================
String message = "Waiting...";
String category = "NOTICE";

String bodyTextColor = "blue";
String headerTextColor = "red";
String borderColor = "green";
String borderStyle = "single";

int brightness = 80;
int scrollSpeed = 3;
String displayMode = "scroll";

int scrollX = PANEL_RES_X;

bool cmdResetDisplay = false;                       // added 
bool cmdRestartDevice = false; 
// COLOR HELPER
// ==========================
uint16_t getColor(String c)
{
  c.toLowerCase();
  if (c == "red")
    return dma_display->color565(255, 0, 0);
  if (c == "green")
    return dma_display->color565(0, 255, 0);
  if (c == "blue")
    return dma_display->color565(0, 0, 255);
  if (c == "yellow")
    return dma_display->color565(255, 255, 0);
  if (c == "white")
    return dma_display->color565(255, 255, 255);
  return dma_display->color565(0, 150, 255);
}

// BORDER DRAW FUNCTION
// ==========================
void drawBorder()
{
  uint16_t col = getColor(borderColor);

  if (borderStyle == "none")
    return;

  if (borderStyle == "single")
  {
    dma_display->drawRect(0, 0, PANEL_RES_X, PANEL_RES_Y, col);
  }

  else if (borderStyle == "double")
  {
    dma_display->drawRect(0, 0, PANEL_RES_X, PANEL_RES_Y, col);
    dma_display->drawRect(1, 1, PANEL_RES_X - 2, PANEL_RES_Y - 2, col);
  }

  else if (borderStyle == "rounded")
  {
    // Fake rounded corners (simple effect)
    dma_display->drawRect(0, 0, PANEL_RES_X, PANEL_RES_Y, col);

    dma_display->drawPixel(0, 0, 0);
    dma_display->drawPixel(PANEL_RES_X - 1, 0, 0);
    dma_display->drawPixel(0, PANEL_RES_Y - 1, 0);
    dma_display->drawPixel(PANEL_RES_X - 1, PANEL_RES_Y - 1, 0);
  }
}

// SETUP
// ==========================
void setup()
{
  Serial.begin(115200);

  HUB75_I2S_CFG::i2s_pins _pins = {
      R1_PIN, G1_PIN, B1_PIN,
      R2_PIN, G2_PIN, B2_PIN,
      A_PIN, B_PIN, C_PIN, D_PIN, E_PIN,
      LAT_PIN, OE_PIN, CLK_PIN};

  HUB75_I2S_CFG mxconfig(PANEL_RES_X, PANEL_RES_Y, PANEL_CHAIN, _pins);
  dma_display = new MatrixPanel_I2S_DMA(mxconfig);
  dma_display->begin();
  dma_display->setTextWrap(false);

  // WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWiFi Connected");

  // Firebase
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;

  Firebase.signUp(&config, &auth, "", "");
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

// LOOP
// ==========================
void loop()
{

  static unsigned long lastFetch = 0;

  if (millis() - lastFetch > 3000)
  {
    lastFetch = millis();

    // NOTICE FETCH
    // ==========================
    if (Firebase.RTDB.getJSON(&fbdo, "/noticeBoard/ESP32_02_11_004/Notice"))
    {

      FirebaseJson &json = fbdo.jsonObject();
      FirebaseJsonData res;

      if (json.get(res, "message"))
        message = res.stringValue;
      if (json.get(res, "category"))
        category = res.stringValue;
    }

    // SETTINGS FETCH
    // ==========================
    if (Firebase.RTDB.getJSON(&fbdo, "/noticeBoard/ESP32_02_11_004/Settings/settings"))
    {

      FirebaseJson &json = fbdo.jsonObject();
      FirebaseJsonData res;

      if (json.get(res, "bodyTextColor"))
        bodyTextColor = res.stringValue;
      if (json.get(res, "headerTextColor"))
        headerTextColor = res.stringValue;
      if (json.get(res, "borderColor"))
        borderColor = res.stringValue;
      if (json.get(res, "borderStyle"))
        borderStyle = res.stringValue;
      if (json.get(res, "brightness"))
        brightness = res.intValue;
      if (json.get(res, "scrollSpeed"))
        scrollSpeed = res.intValue;
      if (json.get(res, "displayMode"))
        displayMode = res.stringValue;
    }

    //          COMMAND FETCH
    //=====================================
    if (Firebase.RTDB.getJSON(&fbdo, "/noticeBoard/ESP32_02_11_004/Settings/commands")) {       // this condition to check command data

      FirebaseJson &json = fbdo.jsonObject();
      FirebaseJsonData res;

      if (json.get(res, "resetDisplay")) cmdResetDisplay = res.boolValue;
      if (json.get(res, "restartDevice")) cmdRestartDevice = res.boolValue;
    }
  }


  // ----------- RESET DISPLAY ------------
  if (cmdResetDisplay) {

    FirebaseJson json;
    json.set("message", "");
    json.set("category", "");
    json.set("symbol", "");
    // json.set("isActive", false);

    Firebase.RTDB.updateNode(
      &fbdo,
      "/noticeBoard/ESP32_02_11_004/Notice",
      &json
    );

    Firebase.RTDB.setBool(
      &fbdo,
      "/noticeBoard/ESP32_02_11_004/Settings/commands/resetDisplay",
      false
    );
  }


  //  ---------RESET DEVICE---------

  if (cmdRestartDevice) {

    Serial.println("Restart command received");    //------------this will be removed for batter stoarage  (ALL SERIAL Println)

    // Reset flag BEFORE restart
    Firebase.RTDB.setBool(&fbdo, "/noticeBoard/ESP32_02_11_004/Settings/commands/restartDevice", false);

    delay(300);
    ESP.restart();
  }

  // DISPLAY
  // ==========================
  dma_display->clearScreen();

  dma_display->setBrightness8(brightness);

  // Border
  drawBorder();

  // Header
  dma_display->setTextColor(getColor(headerTextColor));
  int w = category.length() * 6;
  int cx = (PANEL_RES_X - w) / 2;
  dma_display->setCursor(cx, 5);
  dma_display->print(category);

  // Message
  dma_display->setTextColor(getColor(bodyTextColor));

  if (displayMode == "scroll")
  {
    dma_display->setCursor(scrollX, 22);
    dma_display->print(message);

    scrollX -= scrollSpeed;

    int len = message.length() * 6;
    if (scrollX < -(len + 20))
      scrollX = PANEL_RES_X;
  }
  else
  {
    dma_display->setCursor(2, 22);
    dma_display->print(message);
  }

  delay(30);
}
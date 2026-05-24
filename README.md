# IoT-Enabled Digital Notice Board

A realtime cloud-connected digital notice board system built using **ESP32**, **Firebase**, **Flutter**, and **HUB75E RGB LED Matrix Display** for wireless notice management and realtime display synchronization.



<p align="center">
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779619719/Screenshot_20260517-015835_q6fbiz.png" width="17.7%" /><img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779619295/WhatsApp_Image_2026-05-18_at_23.09.09_rurplo.jpg" width="70%" />
</p>



---

# 📌 Project Overview

Traditional notice boards require manual updates, consume paper, and cannot provide realtime remote communication. This project solves these limitations by implementing an IoT-based digital notice management system capable of publishing notices remotely through cloud communication.

The system uses:

- **Flutter Mobile Application** for notice management
- **Firebase Cloud Services** for realtime synchronization
- **ESP32 Microcontroller** for embedded processing
- **HUB75E RGB LED Matrix Display** for realtime visual output

Whenever a notice is published from the mobile application, the ESP32 automatically fetches updated data from Firebase Realtime Database and displays it on the LED matrix display in realtime.

---

# 🚀 Features

- Realtime cloud synchronization
- Wireless notice publishing
- Firebase Authentication system
- Email verification support
- Realtime display updates
- HUB75E RGB LED matrix rendering
- Scrolling text display
- Dynamic brightness control
- Text color customization
- Border style customization
- NTP-based realtime clock display
- Automatic notice expiry handling
- ESP32 remote restart support
- DMA-based smooth rendering

---

# 🛠️ Technologies Used

## Mobile Application
- Flutter
- Dart

## Cloud Services
- Firebase Authentication
- Firebase Realtime Database
- Cloud Firestore

## Embedded System
- ESP32
- Arduino IDE
- Firebase ESP Client Library

## Display System
- HUB75E RGB LED Matrix
- ESP32-HUB75-MatrixPanel-I2S-DMA Library

---

# 🧩 System Architecture

```text
Flutter App
     │
     ▼
Firebase Cloud Services
     │
     ▼
ESP32 Controller
     │
     ▼
HUB75E RGB LED Matrix Display
```

# 📱 Mobile Application Features

- User Registration  
- Secure Login  
- Email Verification  
- Forgot Password  
- Notice Publishing  
- Display Settings Management  
- Realtime Notice Monitoring  
- Brightness Control  
- Scroll Speed Management  
- Notice Expiry Configuration  

---

# 🔌 Hardware Components

| Component | Description |
|---|---|
| ESP32 | Main IoT Controller |
| HUB75E RGB LED Matrix | Display Output Device |
| Power Supply | 5V External Supply |
| WiFi Network | Cloud Communication |
| USB Cable | ESP32 Programming |

---

# 🔗 ESP32 and HUB75E Connections

| HUB75E Signal | ESP32 GPIO |
|---|---|
| R1 | GPIO 25 |
| G1 | GPIO 26 |
| B1 | GPIO 27 |
| R2 | GPIO 14 |
| G2 | GPIO 12 |
| B2 | GPIO 13 |
| A | GPIO 23 |
| B | GPIO 19 |
| C | GPIO 5 |
| D | GPIO 2 |
| E | GPIO 15 |
| LAT | GPIO 4 |
| OE | GPIO 16 |
| CLK | GPIO 18 |

---

# ☁️ Firebase Realtime Database Structure

```json
{
  "noticeBoard": {
    "noticeBoardId": {

      "Notice": {
        "message": "Welcome",
        "category": "NOTICE",
        "symbol": "",
        "expiryAt": "0"
      },

      "Settings": {

        "settings": {
          "bodyTextColor": "blue",
          "headerTextColor": "red",
          "borderColor": "green",
          "borderStyle": "single",
          "brightness": 80,
          "scrollSpeed": 3,
          "displayMode": "scroll"
        },

        "commands": {
          "resetDisplay": false,
          "restartDevice": false
        }

        "wifi": {
          "ssid": "wifi_name",
          "password": "wifi_password"
        }

      }
    }
  }
}
```
# ⏰ Notice Expiry Logic

The system uses:

- NTP time synchronization  
- Epoch timestamp comparison  

Expired notices are automatically removed from:

- ESP32 display  
- Firebase Realtime Database  

After expiry, the system automatically switches to realtime clock mode.

---

# 📡 Realtime Communication Workflow

1. User publishes notice from Flutter app  
2. Firebase updates Realtime Database  
3. ESP32 fetches updated notice  
4. HUB75E display updates instantly  
5. Notice expiry monitored continuously  
6. Clock mode activated after expiry  

---

# 📷 Project Modules

- Flutter Mobile Application  
- Firebase Cloud Backend  
- ESP32 Firmware  
- HUB75E Display Interface  
- Realtime Synchronization System  
- NTP Clock System  
- DMA-Based Rendering Engine  

---

# ⚠️ Challenges Faced

- HUB75E driver IC compatibility  
- Firebase SSL communication stability  
- DMA rendering optimization  
- Memory management during JSON parsing  
- Stable realtime synchronization  

---

# 📈 Future Improvements

- Multi-display synchronization  
- Web dashboard integration  
- OTA firmware updates  
- Voice announcement system  
- MQTT communication support  
- Smart campus integration  

---

# 📚 References

- ESP32 Documentation  
- Firebase Documentation  
- Flutter Documentation  
- Firebase ESP Client Library  
- HUB75 RGB Matrix Documentation  

---

# 👨‍💻 Authors

Developed as a **4th Semester Micro Project**  
Department of Electronics and Communication Engineering  

---

# 📄 License

This project is developed for academic and educational purposes.
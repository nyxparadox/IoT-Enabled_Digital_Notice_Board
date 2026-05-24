#  Notice<span style="color:red;">Desk</span> – <span style = "font-size: 90%;">Smart IoT Digital Notice Board Management System

<p align="center">
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779627203/app_icon_-1_-modified_edzblw.png" width="180"/>
</p>
<p align = "center">
    <b style="font-size: 200%;">Notice</b><b style="color:red; font-size: 200%;">Desk</b>
<p align="center">
  <b>Realtime IoT Notice Management Mobile Application</b>
</p>

---

# 📌 Overview

NoticeDesk is a production-oriented Flutter and Firebase based smart digital notice board management application developed for realtime institutional communication using IoT architecture.

The application enables authorized users to remotely publish notices from a mobile application to an ESP32-powered HUB75E RGB LED matrix display in realtime using Firebase cloud services.

The system was developed as part of the **IoT-Enabled Digital Notice Board** project and focuses on realtime synchronization, scalable cloud communication, responsive mobile UI engineering, and embedded IoT integration.

---

# 🚀 Key Features

- Realtime Notice Broadcasting  
- Firebase Authentication  
- Email Verification System  
- Session Persistence  
- Smart Notice Management  
- Current Display Monitoring  
- Automatic Notice Expiry  
- Dynamic Display Settings Control  
- Responsive Mobile UI  
- Firebase Hybrid Architecture  
- Realtime Cloud Synchronization  
- ESP32 Communication Support  
- HUB75E LED Matrix Integration  

---

# 🛠️ Technology Stack

## 📱 Frontend
- Flutter  
- Dart  

## ☁️ Backend Services
- Firebase Authentication  
- Firebase Firestore  
- Firebase Realtime Database  

## 🧠 State Management
- Flutter Bloc  
- Cubit Architecture  

## 🧩 Dependency Injection
- GetIt Service Locator  

---

# 🧩 Software Architecture

```text
Flutter Application
        │
        ▼
Cubit / Bloc State Management
        │
        ▼
Repository Layer
        │
 ┌──────┴────────┐
 ▼               ▼
Firestore      Realtime Database
(History)      (Realtime Sync)
        │
        ▼
ESP32 IoT Controller
        │
        ▼
HUB75E RGB LED Matrix Display
```

# ☁️ Firebase Hybrid Architecture

NoticeDesk uses a hybrid Firebase architecture combining:

- Firebase Firestore  
- Firebase Realtime Database  

This architecture improves:

- scalability  
- realtime performance  
- Firebase cost optimization  
- embedded synchronization efficiency  

---

# 🔥 Firestore Responsibilities

Firestore is used for:

- Notice history  
- Archived notices  
- User data  
- Structured metadata  
- Scalable document storage  

---

# ⚡ Firebase Realtime Database Responsibilities

Realtime Database is used for:

- Active notice state  
- Display settings  
- Realtime synchronization  
- ESP32 communication  
- Notice expiry management  

---

# ❓ Why Hybrid Firebase Architecture?

Using only Firestore would:

- increase latency  
- increase cost  
- complicate embedded synchronization  

Using only Realtime Database would:

- reduce scalability  
- weaken structured data handling  

Therefore:

- **Firestore → Permanent Storage**  
- **RTDB → Realtime Active State**  

This creates a balanced architecture optimized for IoT communication systems.

---

# 📡 Application Workflow

## 📨 Notice Sending Workflow

1. User logs into application  
2. User creates notice  
3. Notice saved permanently in Firestore  
4. Active notice updated in RTDB  
5. ESP32 receives realtime update  
6. HUB75E display updates instantly  

---

## ⏰ Notice Expiry Workflow

1. User enables expiry option  
2. User selects expiry date and time  
3. Expiry timestamp stored in RTDB  
4. ESP32 continuously checks expiry timestamp  
5. Notice automatically clears after expiry  
6. Display returns to default clock mode  

---

# 📱 Application Screens

<p align="center">
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630881/Screenshot_20260517-030254_2_2_dfivfz.jpg" width="15.56%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630784/Screenshot_20260516-045811_shnkmy.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630567/Screenshot_20260523-031554_dpobmv.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630546/Screenshot_20260523-031626_udsjvl.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630620/Screenshot_20260516-045809_wqkicu.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630883/Screenshot_20260517-020010_yvsjje.png" width="15%"/>
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779632006/WhatsApp_Image_2026-05-24_at_19.42.24_x6yxpf.jpg" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779633045/WhatsApp_Image_2026-05-24_at_19.55.07_h49uyh.jpg" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779633046/WhatsApp_Image_2026-05-24_at_19.55.06_1_rkbrhl.jpg" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779633047/WhatsApp_Image_2026-05-24_at_19.55.06_nkxmoo.jpg" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630816/Screenshot_20260514-185526_try48h.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630882/Screenshot_20260516-045735_wqs9fl.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630690/Screenshot_20260517-015932_oswypc.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630579/Screenshot_20260517-015845_wqfrwm.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630610/Screenshot_20260517-015851_qsl3u8.png" width="15%" />
  <img src="https://res.cloudinary.com/dytuvjwqu/image/upload/v1779630558/Screenshot_20260523-031246_wp4pcp.png" width="15%" />
</p>

---

# 🧱 Core UI Components

## 🏠 Home Screen

- Current Notice Card  
- Notice Input Section  
- Category Selection  
- Icon Selection  
- Expiry Selection  
- Send Notice Button  

---

## 📄 Current Notice Card

Displays:

- Live active notice  
- Category  
- Timestamps  
- Expiry status  
- Notice icon  

---

## ⏳ Expiry Section

Supports:

- Expiry toggle  
- Date picker  
- Time picker  
- Expiry validation  

---

# 📐 Responsive UI Design

The application was optimized for different mobile screen sizes using:

- adaptive layouts  
- proportional resizing  
- overflow prevention  
- responsive text wrapping  

Implemented using:

- Expanded  
- Flexible  
- FittedBox  
- softWrap  
- maxLines  

---

# 🧠 State Management

Cubit architecture was implemented for:

- cleaner logic separation  
- reduced boilerplate  
- maintainable code structure  

Implemented Cubits:

- AuthCubit  
- NoticeCubit  
- SettingsCubit  

---

# 🗂️ Repository Architecture

Repositories abstract Firebase operations from UI components.

Implemented repositories:

- AuthRepository  
- NoticeRepository  
- SettingsRepository  

Benefits:

- modularity  
- scalability  
- maintainability  
- cleaner architecture  

---

# 🔌 Dependency Injection

GetIt service locator was implemented for:

- centralized dependency management  
- singleton service handling  
- cleaner architecture  
- reduced object coupling  

---

# 🔐 Security Features

- Firebase Authentication  
- Email Verification  
- Session Management  

Future security upgrades:

- Role-based access control  
- Firebase security rules  
- Board ownership validation  

---

# ⚡ Performance Optimizations

The system was optimized for Firebase Spark Plan (Free Tier).

Optimization techniques:

- lightweight RTDB usage  
- minimal Firebase reads/writes  
- hybrid Firebase architecture  
- no backend server requirement  
- no Cloud Functions dependency  

---

# 🔥 Firebase Realtime Database Structure

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
          "ssid": wifi_name,
          "password": wifi_password
        }

      }
    }
  }
}
```
# ⚠️ Challenges Faced

- Firebase SSL communication stability  
- Realtime synchronization optimization  
- Responsive UI engineering  
- State management complexity  
- Firebase cloud structure management  
- ESP32 synchronization handling  
- Embedded communication reliability  

---

# 📈 Future Improvements

Planned upgrades include:

- Multiple notice board support  
- OTA firmware updates  
- Analytics dashboard  
- Role-based user permissions  
- Notice scheduling system  
- Board monitoring system  
- Priority notices  
- Activity logs  
- Push notifications  

---

# 🎯 Project Goals Achieved

The project successfully demonstrates:

- Flutter application development  
- Firebase cloud integration  
- Realtime synchronization  
- Responsive UI engineering  
- IoT-oriented software architecture  
- Embedded system integration  
- Scalable mobile application design  

---

# 👨‍💻 Developed For

**IoT-Enabled Digital Notice Board**  
4th Semester Micro Project  
Department of Electronics and Communication Engineering  

---

# 📄 License

This project is developed for academic and educational purposes.
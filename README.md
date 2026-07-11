# 🚨 Women Safety App

A full-stack mobile application developed to provide emergency assistance and safety support for women using SOS alerts, live location tracking, emergency contacts, and SMS-based emergency communication.

---

## 📌 Project Overview

Women Safety App is a Flutter-based mobile application integrated with a Node.js and MongoDB backend.

The main purpose of this application is to provide quick emergency support during unsafe situations. Users can register, manage trusted emergency contacts, trigger SOS alerts, share their current location, and maintain SOS history.

The application focuses on improving personal safety by providing a fast and reliable emergency response system.

---

# ✨ Features

## 🔐 User Authentication

- User Registration
- Secure Login
- JWT based authentication
- Password encryption using bcrypt
- Persistent login session using local storage

---

## 👥 Emergency Contact Management

- Add emergency contacts
- View saved contacts
- Update contact details
- Delete contacts
- Direct call option for saved contacts

---

## 🚨 SOS Emergency System

- One tap SOS activation
- 3 seconds countdown before SOS trigger
- Cancel SOS option to prevent accidental alerts
- Fetch current GPS location
- Generate emergency message
- Send emergency SMS alert
- Save SOS details in database

---

## 📍 Location Services

- Current location tracking using GPS
- Google Maps integration
- View live location
- Find nearby police stations

---

## 📜 SOS History

- View previous SOS alerts
- Store multiple SOS records
- Track SOS status
- Resolve SOS alerts

---

# 🛠️ Technology Stack

## Frontend

- Flutter
- Dart

## Backend

- Node.js
- Express.js

## Database

- MongoDB Atlas

## Authentication

- JWT (JSON Web Token)
- bcrypt Password Hashing

## APIs & Services

- REST APIs
- Geolocator API
- SMS Integration
- Google Maps Integration

## Deployment

- Render (Backend Hosting)
- Android Release APK

---

# 🏗️ System Architecture

```
             Flutter Mobile Application
                       |
                       |
                    REST API
                       |
                       |
             Node.js + Express Server
                       |
                       |
                 MongoDB Atlas
```

---

# 📂 Project Structure

```
Women-Safety-App

│
├── frontend
│
│   └── Flutter Application
│
│       ├── screens
│       ├── services
│       ├── widgets
│       └── theme
│
│
└── backend
    │
    ├── config
    │
    ├── controllers
    │
    ├── middleware
    │
    ├── models
    │
    ├── routes
    │
    └── server.js
```

---

# ⚙️ Installation Guide

## Backend Setup

### Clone Repository

```bash
git clone <repository-url>
```

Navigate to backend folder:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

Create `.env` file:
```env
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key
PORT=5000
```

Start backend server:

```bash
npm run dev
```

---

## Flutter Setup

Navigate to frontend folder:

```bash
cd frontend
```

Install packages:

```bash
flutter pub get
```

Run application:

```bash
flutter run
```

---

# 🔑 API Modules

## User APIs

- Register User
- Login User
- Get User Profile

## Contact APIs

- Add Emergency Contact
- Get Emergency Contacts
- Update Contact
- Delete Contact

## SOS APIs

- Trigger SOS
- Save SOS Location
- Get SOS History
- Resolve SOS Alert


---

# 🔮 Future Enhancements

- Push Notifications
- Shake Detection SOS Trigger
- Voice Activated SOS
- Emergency Contact Application
- Real-time Live Location Sharing
- Admin Dashboard
- AI based Safety Prediction System

---

# 🎯 Learning Outcomes

Through this project, I learned:

- Full-stack mobile application development
- Flutter UI development
- REST API integration
- Backend development using Node.js
- Database management using MongoDB
- Authentication and security implementation
- Cloud deployment
- Real device testing

---

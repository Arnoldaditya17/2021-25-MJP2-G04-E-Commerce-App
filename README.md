# 🛒 E-Commerce Mobile Application

This is a full-stack e-commerce application built using **Flutter** for the mobile client and **Spring Boot** for the backend server. It features user registration/login, product listing, cart management, order placement, and inventory handling.

---

## 🔗 Repository

> GitHub Repo: [2021-25-MJP2-G04-E-Commerce-App](https://github.com/Arnoldaditya17/2021-25-MJP2-G04-E-Commerce-App.git)

---


---

## 🔧 Tech Stack

### 📱 Flutter (Client)

- **Flutter Version**: 3.24.1 • `stable` channel  
- **Dart Version**: 3.5.1  
- **DevTools**: 2.37.2  
- **Flutter Git**: [Flutter Repo](https://github.com/flutter/flutter.git)  
- **Framework Revision**: 5874a72aa4 (2024-08-20)

### 🌐 Spring Boot (Server)

- **Java**: 11  
- **Apache Maven**: 3.8.8  
- **Spring Boot**: Compatible with version 2.7+

---

## 🚀 Getting Started

### 🔁 Clone the Repository

git clone https://github.com/Arnoldaditya17/2021-25-MJP2-G04-E-Commerce-App.git
cd 2021-25-MJP2-G04-E-Commerce-App

📲 Flutter Setup (Client)
✅ Prerequisites
Flutter SDK: Install Guide

Android Studio or Visual Studio Code

Emulator or physical device

cd client

# Get dependencies
flutter pub get

# Run the app
flutter run

⚙️ Spring Boot Setup (Server)
✅ Prerequisites
Java 11 installed

Apache Maven 3.8.8

MySQL running locally or on a server

▶️ Run the Backend

cd server/app-starter

# Clean and build the project
mvn clean install

# Run the Spring Boot server
mvn spring-boot:run

🛠️ application.properties Configuration
Path: server/app-starter/src/main/resources/application.properties

# Application Port
server.port=8080

# MySQL Database Configuration (Edit as needed)
spring.datasource.url=jdbc:mysql://localhost:3306/ecommerce
spring.datasource.username=root
spring.datasource.password=yourpassword
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# Hibernate Settings
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# CORS (Allow requests from Flutter)
spring.web.cors.allowed-origins=*
spring.web.cors.allowed-methods=GET,POST,PUT,DELETE,OPTIONS





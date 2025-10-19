# 🏨 Palace HR

**Palace HR** is a smart and intuitive app for managing employees with ease. It tracks attendance using location and face verification, manages schedules, leaves, and payroll, and gives full control over leave requests, permissions, penalties, and monthly work shifts — all in one professional system.

---

## 🖼️ App Preview

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/05c00f08-f7ee-41cf-9cea-55a8d4fa7749" width="200">
      <br>
      <b>Splash Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/2c1cb59b-055b-4e47-93f0-900084b8bb7b" width="200">
      <br>
      <b>Login Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/e3f6376a-08e0-4134-a65f-c606d716a455" width="200">
      <br>
      <b>Selfie Prompt Screen</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/24dd3ad1-73b9-418e-912d-536ebd6b8655" width="200">
      <br>
      <b>Home Screen</b>
    </td>
    <td align="center">
      <img src= "https://github.com/user-attachments/assets/da6ee02f-f642-4a04-8567-dbacd3867c90" width="200">
      <br>
      <b>Penalties Screen</b>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src= "https://github.com/user-attachments/assets/85c1029e-e561-4d3a-a7a8-55c548c2ff19" width="200">
      <br>
      <b>Requests Screen</b>
    </td>
      <td align="center">
      <img src= "https://github.com/user-attachments/assets/89d1cdf1-1858-49c2-9f41-b379947a365d" width="200">
      <br>
      <b>New Request Screen</b>
    </td>
    </td>
      <td align="center">
      <img src= "https://github.com/user-attachments/assets/68a0db34-5c6e-40ba-8361-bad5dd8b83c9" width="200">
      <br>
      <b>Settings Screen</b>


  </tr>
</table>
---

## 👨‍💼 Admin Screens

<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/9ef6c277-718a-46f8-975d-5fdb63c0966b" width="200">
      <br>
      <b>Admin Dashboard</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/318249ad-9fd1-44f5-81b1-6f3b995baab4" width="200">
      <br>
      <b>Requests Management</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/dd7bec54-93da-45bf-a1e0-4b635fbcfbd9" width="200">
      <br>
      <b>Employees Details</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/ccf8ac25-bbd1-4c56-a050-7e82150555d8" width="200">
      <br>
      <b>Change Shift Screen</b>
    </td>

  
  </tr>
</table>
---

## 🧩 Technologies & Packages Used

### 🧱 Core Framework  
- **Flutter** – Cross-platform framework for building the Palace HR app using **Clean Architecture + Cubit**.  

### ☁️ Backend & Authentication  
- **Firebase Auth** – Handles user authentication securely.  
- **Cloud Firestore** – Real-time database for storing employee, attendance, and leave data.  
- **Supabase** – Used for additional backend features and cloud storage.

### 📍 Location & Face Verification  
- **Geolocator** – Detects user’s real-time location for attendance validation.  
- **Google ML Kit (Face Detection)** & **Flutter Face API** – Used for facial recognition check-in/out.

### 🗓 Attendance & Scheduling  
- **Table Calendar**, **Easy Date Timeline**, **Calendar Timeline** – For managing schedules, shifts, and attendance logs.

### 💾 Local Storage & Caching  
- **Shared Preferences** – Stores user session and small data locally.  
- **Cached Network Image** – For fast and optimized image loading.

### 🧰 State Management & Dependency Injection  
- **Flutter Bloc (Cubit)** – For structured state management.  
- **Get It** – For dependency injection and service locator pattern.

### 🎨 UI / UX  
- **Flutter ScreenUtil** – For responsive UI across all devices.  
- **Flutter SVG** & **Font Awesome Flutter** – For icons and vector graphics.  
- **Animate Do** & **Flutter Animate** – For smooth transitions and animations.  
- **Smooth Page Indicator** – Used in onboarding and intro screens.

### 🧮 Utilities & Helpers  
- **Dartz** – Functional programming helpers (Either, Option).  
- **Intl** – For date and number formatting.  
- **HTTP** – Handles external API calls.  
- **Build Runner** & **JSON Serializable** – For model generation and code automation.

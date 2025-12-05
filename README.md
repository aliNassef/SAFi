# SAFI - Service Application Flutter Implementation

A comprehensive Flutter application built with clean architecture principles, providing services management with real-time features, payment integration, and location-based services.

## 📱 Tech Stack

### Core Framework
- **Flutter SDK**: ^3.9.2
- **Dart**: ^3.9.2

### State Management & Architecture
- **flutter_bloc**: ^9.1.1 - State management using BLoC pattern
- **hydrated_bloc**: ^10.1.1 - Persistent state management
- **get_it**: ^9.0.5 - Dependency injection
- **equatable**: ^2.0.7 - Value equality for state comparison
- **dartz**: ^0.10.1 - Functional programming (Either, Option)

### Firebase Services
- **firebase_core**: ^4.2.1 - Firebase initialization
- **firebase_auth**: ^6.1.2 - User authentication
- **cloud_firestore**: ^6.1.0 - NoSQL database
- **firebase_messaging**: ^16.0.4 - Push notifications (FCM)
- **firebase_crashlytics**: ^5.0.5 - Crash reporting
- **firebase_analytics**: ^12.0.4 - Analytics tracking
- **firebase_storage**: ^13.0.4 - File storage

### Payment Integration
- **flutter_stripe**: ^12.1.1 - Stripe payment processing
- **flutter_paypal_payment**: ^1.0.8 - PayPal integration

### Location & Maps
- **google_maps_flutter**: ^2.14.0 - Google Maps integration
- **place_picker_google**: ^0.0.20 - Place picker widget
- **geolocator**: ^14.0.2 - Location services
- **permission_handler**: ^12.0.1 - Runtime permissions

### UI/UX
- **flutter_screenutil**: ^5.9.3 - Responsive UI design
- **google_fonts**: ^6.3.2 - Custom fonts
- **flutter_svg**: ^2.2.1 - SVG rendering
- **cached_network_image**: ^3.4.1 - Image caching
- **animate_do**: ^4.2.0 - Animations
- **skeletonizer**: ^2.1.0+1 - Skeleton loading screens
- **carousel_slider**: ^5.1.1 - Carousel widgets
- **dropdown_button2**: ^2.3.9 - Advanced dropdown menus
- **dots_indicator**: ^4.0.1 - Page indicators
- **persistent_bottom_nav_bar_v2**: ^6.2.0 - Bottom navigation

### Localization & Utilities
- **easy_localization**: ^3.0.8 - Multi-language support (Arabic & English)
- **flutter_local_notifications**: ^19.5.0 - Local notifications
- **phone_form_field**: ^10.0.12 - Phone number input/validation
- **otp_pin_field**: ^1.4.1 - OTP input fields
- **image_picker**: ^1.2.1 - Image selection from gallery/camera

### Storage & Networking
- **flutter_secure_storage**: ^9.2.4 - Encrypted secure storage
- **shared_preferences**: ^2.5.3 - Key-value storage
- **path_provider**: ^2.1.5 - File system paths
- **dio**: ^5.9.0 - HTTP networking
- **internet_connection_checker_plus**: ^2.7.2 - Connectivity monitoring

### Development Tools
- **envied**: ^1.3.1 - Environment variables management
- **flutter_lints**: ^5.0.0 - Linting rules
- **build_runner**: ^2.10.4 - Code generation
- **envied_generator**: ^1.3.1 - Environment code generation
- **flutter_native_splash**: ^2.4.7 - Native splash screens

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **Feature-First** organization:

```
lib/
├── core/                          # Shared application core
│   ├── controller/               # Global state management
│   ├── di/                       # Dependency injection setup
│   ├── enums/                    # Application-wide enums
│   ├── errors/                   # Error handling & failures
│   ├── extensions/               # Dart extensions
│   ├── helpers/                  # Helper functions
│   ├── logging/                  # Logging utilities
│   ├── navigation/               # Routing & navigation
│   ├── services/                 # Core services
│   │   ├── fcm_service.dart
│   │   ├── firebase_auth_service.dart
│   │   ├── firebase_firestore_service.dart
│   │   ├── fire_storage_service.dart
│   │   ├── geolocator_service.dart
│   │   ├── location_service.dart
│   │   ├── local_notification_service.dart
│   │   └── stripe_service.dart
│   ├── translations/             # Localization files
│   ├── utils/                    # Utility classes
│   └── widgets/                  # Reusable widgets
│
├── features/                      # Feature modules
│   ├── auth/                     # Authentication feature
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   └── repo/
│   │   └── presentation/
│   │       ├── controller/
│   │       ├── views/
│   │       └── widgets/
│   │
│   ├── home/                     # Home & main dashboard
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   ├── model/
│   │   │   └── repo/
│   │   └── presentation/
│   │       ├── controller/
│   │       ├── views/
│   │       └── widgets/
│   │
│   ├── layout/                   # App layout & navigation
│   │   └── presentation/
│   │       ├── controller/
│   │       └── views/
│   │
│   ├── notifications/            # Push notifications
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   ├── model/
│   │   │   └── repo/
│   │   └── presentations/
│   │       ├── controller/
│   │       ├── view/
│   │       └── widgets/
│   │
│   ├── onboarding/               # Onboarding flow
│   │   ├── data/
│   │   │   └── models/
│   │   └── presentation/
│   │       ├── view/
│   │       └── widgets/
│   │
│   ├── orders/                   # Order management
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   ├── model/
│   │   │   └── repo/
│   │   └── presentation/
│   │       ├── controller/
│   │       ├── views/
│   │       └── widgets/
│   │
│   ├── profile/                  # User profile
│   │   ├── data/
│   │   │   ├── datasource/
│   │   │   ├── model/
│   │   │   └── repo/
│   │   └── presentation/
│   │       ├── controller/
│   │       ├── views/
│   │       └── widgets/
│   │
│   ├── splash/                   # Splash screen
│   │   └── presentation/
│   │       └── views/
│   │
│   ├── subscription/             # Subscription management
│   │   ├── data/
│   │   └── presentation/
│   │
│   └── transactions/             # Payment transactions
│       ├── data/
│       └── presentation/
│
├── env/                          # Environment configurations
├── firebase_options.dart         # Firebase configuration
├── main.dart                     # Application entry point
└── safi_app.dart                 # Root app widget
```

### Architecture Layers

Each feature follows a **3-layer architecture**:

1. **Presentation Layer**
   - `controller/` - BLoC/Cubit state management
   - `views/` - Screen/page widgets
   - `widgets/` - Feature-specific reusable widgets


2. **Data Layer**
   - `datasource/` - Remote (Firebase) and local data sources
   - `model/` - Data models
   - `repo/` - Repository implementations

## ✨ Features

### 🔐 Authentication
- Phone number authentication with OTP verification
- Firebase Authentication integration
- Secure token storage
- Session management

### 🏠 Home & Dashboard
- Service browsing and discovery
- Real-time data updates
- Carousel for featured services
- Skeleton loading states

### 📦 Orders Management
- Create and track orders
- Real-time order status updates
- Order history and details
- Firestore integration for data persistence

### 💳 Payment Integration
- **Stripe** payment processing
- Secure payment handling
- Transaction history tracking

### 🔔 Notifications
- Firebase Cloud Messaging (FCM) for push notifications
- Local notifications
- Real-time notification updates
- Notification read/unread status

### 📍 Location Services
- Google Maps integration
- Place picker for address selection
- Real-time location tracking
- Geolocation permissions handling

### 👤 User Profile
- Profile management
- User data persistence
- Profile image upload to Firebase Storage
- Settings and preferences

### 📱 Subscription
- Subscription plan management
- Plan selection and activation
- Subscription status tracking

### 💰 Transactions
- View transaction history
- Payment records
- Transaction details and receipts

### 🌍 Localization
- Multi-language support (Arabic & English)
- RTL/LTR layout support
- Dynamic locale switching

### 📶 Network Monitoring
- Real-time internet connection status
- No internet banner display
- Automatic reconnection handling

### 🎨 UI/UX Features
- Responsive design for different screen sizes
- Dark/Light theme support (configured)
- Smooth animations and transitions
- Custom fonts (Google Fonts)
- Image caching for performance
- Native splash screen

### 📊 Analytics & Monitoring
- Firebase Analytics integration
- Crash reporting with Crashlytics
- Error tracking and logging

## 📂 Folder Structure

```
safi/
├── android/                      # Android native code
├── ios/                          # iOS native code
├── assets/                       # Asset files
│   ├── images/                  # Image assets
│   ├── svgs/                    # SVG icons
│   └── translations/            # Localization JSON files
│       ├── ar.json              # Arabic translations
│       └── en.json              # English translations
├── lib/                         # Main application code
│   ├── core/                    # Shared core functionality
│   ├── features/                # Feature modules
│   ├── env/                     # Environment variables
│   ├── firebase_options.dart   # Firebase configuration
│   ├── main.dart                # App entry point
│   └── safi_app.dart            # Root widget
├── test/                        # Unit & widget tests
├── pubspec.yaml                 # Dependencies configuration
└── README.md                     # Project documentation
```

## 🚀 How to Run the Project

### Prerequisites

Before running the project, ensure you have the following installed:

- **Flutter SDK** (version 3.9.2 or higher)
- **Dart SDK** (version 3.9.2 or higher)
- **Android Studio** or **Xcode** (for mobile development)
- **Firebase CLI** (for Firebase project setup)
- **Git** (for version control)

### Environment Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd safi
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   
   Create environment configuration files in the `lib/env/` directory. You'll need to configure:
   - Stripe API keys
   - PayPal credentials
   - Google Maps API key
   - Any other API keys

4. **Generate environment files**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Firebase Setup**
   
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android and/or iOS apps to your Firebase project
   - Download and place the configuration files:
     - `google-services.json` in `android/app/`
     - `GoogleService-Info.plist` in `ios/Runner/`
   - Enable the following Firebase services:
     - Authentication (Phone)
     - Cloud Firestore
     - Firebase Storage
     - Cloud Messaging
     - Crashlytics
     - Analytics

6. **Configure Google Maps**
   
   Add your Google Maps API key in:
   - **Android**: `android/app/src/main/AndroidManifest.xml`
   - **iOS**: `ios/Runner/AppDelegate.swift`

### Running the Application

#### Development Mode

```bash
# Run on connected device or emulator
flutter run

# Run with specific flavor (if configured)
flutter run --flavor dev

# Run in release mode
flutter run --release
```

#### Build for Production

**Android (APK)**
```bash
flutter build apk --release
```

**Android (App Bundle)**
```bash
flutter build appbundle --release
```

**iOS**
```bash
flutter build ios --release
```

### Code Generation

If you modify generated files (models, environment configs), run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### Common Issues & Solutions

**Issue: Firebase configuration not found**
- Solution: Ensure `google-services.json` and `GoogleService-Info.plist` are in the correct locations

**Issue: Build runner conflicts**
- Solution: Run `flutter pub run build_runner build --delete-conflicting-outputs`

**Issue: Missing environment variables**
- Solution: Check that all required API keys are configured in `lib/env/`

**Issue: Google Maps not showing**
- Solution: Verify Google Maps API key is properly configured and enabled in Google Cloud Console

**Issue: Permission errors on Android/iOS**
- Solution: Check that required permissions are added in `AndroidManifest.xml` and `Info.plist`

## 📝 Additional Notes

### Supported Platforms
- ✅ Android
- ✅ iOS
- ⚠️ Web (limited support - some features may not work)

### Minimum Requirements
- **Android**: API Level 21 (Android 5.0) or higher
- **iOS**: iOS 12.0 or higher

### Version
Current version: **0.1.4**

## 🤝 Contributing

When contributing to this project:

1. Follow the established architecture patterns
2. Write tests for new features
3. Use the Flutter linter rules
4. Run `dart format .` before committing
5. Follow the SOLID principles
6. Ensure all features work in both Arabic and English

## 📄 License

This project is private and not for public distribution.

---

**Built with ❤️ using Flutter**
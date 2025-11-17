# Technology Stack

## Framework & Language
- **Flutter** (SDK ^3.7.2) - Cross-platform mobile development framework
- **Dart** - Primary programming language

## State Management & Architecture
- **GetX** (^4.7.2) - State management, dependency injection, and routing
- **Clean Architecture** pattern with feature-based organization
- **MVC pattern** with controllers for business logic

## Key Dependencies
- **dio** (^5.8.0+1) - HTTP client for API communication
- **flutter_screenutil** (^5.9.3) - Screen adaptation and responsive design
- **shared_preferences** (^2.5.3) - Local data persistence
- **socket_io_client** (^3.1.2) - Real-time communication
- **flutter_local_notifications** (^18.0.0) - Push notifications
- **cached_network_image** (^3.4.1) - Image caching and loading
- **image_picker** (^1.1.2) & **image_cropper** (^9.1.0) - Image handling
- **google_fonts** (^6.2.1) - Custom typography
- **flutter_dotenv** (^5.2.1) - Environment configuration

## Development Tools
- **flutter_lints** (^5.0.0) - Code quality and style enforcement
- **pretty_dio_logger** (^1.4.0) - API request/response logging

## Common Commands

### Development
```bash
# Install dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Run on specific device
flutter run -d <device_id>

# Hot reload (r) and hot restart (R) available during development
```

### Building
```bash
# Build APK (Android)
flutter build apk

# Build iOS
flutter build ios

# Build for web
flutter build web

# Build for all platforms
flutter build apk && flutter build ios
```

### Testing & Analysis
```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Check for outdated dependencies
flutter pub outdated

# Upgrade dependencies
flutter pub upgrade
```

### Environment Setup
- Ensure `.env` file is present in root directory for environment variables
- Configure API endpoints in `lib/config/api/api_end_point.dart`
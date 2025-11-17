# Technology Stack

## Framework & Language

- **Flutter** SDK ^3.7.2
- **Dart** programming language

## State Management & Architecture

- **GetX** (^4.7.2) for state management, dependency injection, and routing
- Clean Architecture with feature-based organization
- MVC pattern with GetX controllers handling business logic

## Key Dependencies

### Networking & Data
- `dio` (^5.9.0) - HTTP client
- `pretty_dio_logger` (^1.4.0) - API logging
- `socket_io_client` (^3.1.2) - Real-time communication
- `shared_preferences` (^2.5.3) - Local storage

### UI & Media
- `flutter_screenutil` (^5.9.3) - Responsive design
- `google_fonts` (^6.3.2) - Typography
- `flutter_svg` (^2.2.1) - SVG support
- `cached_network_image` (^3.4.1) - Image caching
- `image_picker` (^1.2.0) - Image selection

### Utilities
- `flutter_local_notifications` (^18.0.0) - Push notifications
- `flutter_dotenv` (^6.0.0) - Environment variables
- `intl` (^0.20.2) - Internationalization
- `pin_code_fields` (^8.0.1) - PIN input
- `intl_phone_field` (^3.2.0) - Phone number input
- `flutter_html` (^3.0.0) - HTML rendering

## Common Commands

### Development
```bash
flutter pub get              # Install dependencies
flutter run                  # Run in debug mode
flutter run -d <device_id>   # Run on specific device
```

### Building
```bash
flutter build apk            # Build Android APK
flutter build ios            # Build iOS app
flutter build web            # Build web app
```

### Code Quality
```bash
flutter analyze              # Static analysis
flutter test                 # Run tests
flutter pub outdated         # Check outdated packages
flutter pub upgrade          # Upgrade dependencies
```

## Environment Setup

- Create `.env` file in project root for environment variables
- Configure API endpoints in `lib/config/api/api_end_point.dart`
- Secret keys stored in `lib/config/secret_key/secret_key.dart`

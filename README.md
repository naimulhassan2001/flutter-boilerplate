# Flutter Boilerplate

A robust and scalable Flutter boilerplate project designed to jumpstart mobile application development. This project comes pre-configured with essential libraries and a modular architecture to ensure maintainability and efficiency.

## 🚀 Features

-   **State Management**: Utilizes [GetX](https://pub.dev/packages/get) for reactive state management, dependency injection, and route management.
-   **Networking**: Integrated [Dio](https://pub.dev/packages/dio) for handling API requests, complete with interceptors, standardized error handling, and pretty logging.
-   **Responsive Design**: Implements [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil) to ensure UI consistency across different device sizes (design size: 428x926).
-   **Modular Architecture**: Organized by features (Auth, Message, Profile, etc.) to keep code decoupled and manageable.
-   **Local Storage**: Wrapper around [Shared Preferences](https://pub.dev/packages/shared_preferences) for persisting local data.
-   **Socket Integration**: Ready-to-use [Socket.io Client](https://pub.dev/packages/socket_io_client) for real-time communication.
-   **Utils & Helpers**: extensive collection of utility classes and extensions.

## 🛠 Tech Stack

-   **Language**: Dart
-   **Framework**: Flutter
-   **State Management**: GetX
-   **Networking**: Dio, Pretty Dio Logger
-   **UI/UX**: Flutter ScreenUtil, Google Fonts, Flutter SVG, Cached Network Image
-   **Forms**: Intl Phone Field, Pin Code Fields, Image Picker
-   **Utilities**: Flutter Dotenv, Intl, Shared Preferences

## 📂 Project Structure

The project follows a feature-first structure:

```text
lib/
├── component/      # Reusable UI components (Buttons, Inputs, etc.)
├── config/         # App configuration
│   ├── dependency/ # Dependency Injection setup
│   ├── route/      # App Routes
│   └── theme/      # Theme configuration
├── features/       # Feature modules
│   ├── auth/       # Authentication (Login, Register, etc.)
│   ├── message/    # Messaging features
│   ├── profile/    # User profile management
│   └── ...
├── services/       # Core services
│   ├── socket/     # Socket.io service
│   └── storage/    # Local storage service
├── utils/          # Helper functions and constants
├── app.dart        # Main App Widget & ScreenUtil setup
└── main.dart       # App Entry Point & Initialization
```

## 🏁 Getting Started

### Prerequisites

-   [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.10.4 or higher recommended)
-   Dart SDK

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/flutter-boilerplate.git
    cd flutter-boilerplate
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Environment Setup:**

    Create a `.env` file in the root directory (if not already present) to configure your environment variables.
    *Note: Check `lib/main.dart` or source code for required keys.*

4.  **Run the app:**

    ```bash
    flutter run
    ```

## 📦 Building

To build the application for production:

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---
*Generated based on project structure analysis.*

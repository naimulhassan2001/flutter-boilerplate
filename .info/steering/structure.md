# Project Structure & Organization

## Root Directory Structure
```
lib/
├── app.dart                    # Main app configuration with GetMaterialApp
├── main.dart                   # Entry point with initialization
├── component/                  # Reusable UI components
├── config/                     # App configuration (API, routes, theme, etc.)
├── features/                   # Feature-based modules
├── services/                   # Core services (API, storage, etc.)
└── utils/                      # Utilities and helpers
```

## Feature-Based Architecture
Each feature follows clean architecture principles:
```
features/[feature_name]/
├── data/
│   └── model/                  # Data models
├── presentation/
│   ├── controller/             # GetX controllers (business logic)
│   ├── screen/                 # UI screens
│   └── widgets/                # Feature-specific widgets
```

## Component Organization
```
component/
├── button/                     # Button components (CommonButton)
├── image/                      # Image components (CommonImage)
├── other_widgets/              # Misc widgets (loaders, items, no data)
├── pop_up/                     # Popup and menu components
├── screen/                     # Screen-level components (error, no internet)
├── text/                       # Text components (CommonText)
└── text_field/                 # Input field components
```

## Configuration Structure
```
config/
├── api/                        # API endpoints and configuration
├── dependency/                 # Dependency injection setup
├── languages/                  # Internationalization
├── route/                      # App routing configuration
├── secret_key/                 # API keys and secrets
└── theme/                      # App theming
```

## Services Layer
```
services/
├── api/                        # HTTP client and API service
├── location/                   # Location services
├── notification/               # Push notification handling
├── responsive/                 # Screen size adaptation
├── socket/                     # WebSocket/Socket.IO services
└── storage/                    # Local storage (SharedPreferences)
```

## Utilities
```
utils/
├── constants/                  # App constants (colors, strings, images, icons)
├── enum/                       # Enumerations
├── extensions/                 # Dart extensions
├── helpers/                    # Helper functions
└── log/                        # Logging utilities (API, app, error logs)
```

## Naming Conventions

### Files & Directories
- Use **snake_case** for file and directory names
- Screen files end with `_screen.dart`
- Controller files end with `_controller.dart`
- Model files end with `_model.dart`
- Service files end with `_service.dart`

### Classes & Components
- Use **PascalCase** for class names
- Prefix reusable components with "Common" (e.g., `CommonButton`, `CommonText`)
- Controllers extend GetX controllers and end with "Controller"
- Screens are StatelessWidget or StatefulWidget

### Constants & Variables
- Use **camelCase** for variables and methods
- Use **SCREAMING_SNAKE_CASE** for compile-time constants
- Group related constants in dedicated classes (e.g., `AppColors`, `AppString`)

## Route Management
- Routes defined in `lib/config/route/app_routes.dart`
- Route names follow pattern: `"/screen_name.dart"`
- Use GetX navigation: `Get.toNamed(AppRoutes.routeName)`

## Asset Organization
```
assets/
├── images/                     # Image assets
└── icons/                      # Icon assets
```

## Key Architectural Patterns
- **Feature-first organization** - group by business functionality
- **Separation of concerns** - distinct layers for UI, business logic, and data
- **Dependency injection** - centralized in `DependencyInjection` class
- **Responsive design** - using ScreenUtil for consistent sizing
- **Component reusability** - common components for consistent UI
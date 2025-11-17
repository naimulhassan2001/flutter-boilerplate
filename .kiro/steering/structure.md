# Project Structure & Conventions

## Directory Organization

```
lib/
├── app.dart                 # App configuration (GetMaterialApp, theme, routes)
├── main.dart                # Entry point with initialization
├── component/               # Reusable UI components
├── config/                  # Configuration (API, routes, theme, DI, i18n)
├── features/                # Feature modules (clean architecture)
├── services/                # Core services (API, storage, socket, etc.)
└── utils/                   # Utilities, constants, helpers, extensions
```

## Feature Architecture

Each feature follows clean architecture with this structure:

```
features/[feature_name]/
├── data/
│   └── model/              # Data models
├── presentation/
│   ├── controller/         # GetX controllers (business logic)
│   ├── screen/             # UI screens
│   └── widgets/            # Feature-specific widgets
└── repository/             # Data repositories (if needed)
```

## Naming Conventions

### Files & Directories
- **snake_case** for all file and directory names
- Suffixes for file types:
  - `_screen.dart` for screens
  - `_controller.dart` for controllers
  - `_model.dart` for models
  - `_service.dart` for services
  - `_repository.dart` for repositories

### Classes
- **PascalCase** for class names
- Prefix reusable components with `Common` (e.g., `CommonButton`, `CommonText`, `CommonImage`)
- Controllers extend GetX controllers and end with `Controller`
- Screens are `StatelessWidget` or `StatefulWidget`

### Variables & Methods
- **camelCase** for variables, methods, and parameters
- **SCREAMING_SNAKE_CASE** for compile-time constants
- Group constants in dedicated classes: `AppColors`, `AppString`, `AppImages`, `AppIcons`

## Component Library

Reusable components in `lib/component/`:
- `button/` - Button components (CommonButton)
- `image/` - Image components (CommonImage)
- `text/` - Text components (CommonText)
- `text_field/` - Input fields (CommonTextField, CommonPhoneNumberTextField)
- `bottom_nav_bar/` - Navigation bars
- `pop_up/` - Popups and menus
- `screen/` - Screen-level components (ErrorScreen, NoInternet)
- `other_widgets/` - Misc widgets (CommonLoader, NoData, Item)

## Configuration Structure

```
config/
├── api/                    # API endpoints
├── dependency/             # DependencyInjection class
├── languages/              # i18n configuration
├── route/                  # AppRoutes with GetX routing
├── secret_key/             # API keys and secrets
└── theme/                  # Theme configuration
```

## Services Layer

```
services/
├── api/                    # ApiService with Dio, ApiResponseModel
├── firebase/               # Firebase auth and Firestore
├── location/               # Location services
├── notification/           # NotificationService
├── responsive/             # Responsive utilities
├── socket/                 # SocketServices
└── storage/                # LocalStorage with SharedPreferences
```

## Utilities

```
utils/
├── constants/              # AppColors, AppString, AppImages, AppIcons
├── enum/                   # Enumerations
├── extensions/             # Dart extensions
├── helpers/                # Helper functions
└── log/                    # Logging (ApiLog, AppLog, ErrorLog)
```

## Code Patterns

### Initialization
- Main initialization in `main.dart` using `init()` function
- Services initialized with `Future.wait()` for parallel execution
- DependencyInjection registers all controllers with `Get.lazyPut()`

### Navigation
- Routes defined in `lib/config/route/app_routes.dart`
- Use GetX navigation: `Get.toNamed()`, `Get.to()`, `Get.off()`, `Get.back()`
- Route names follow pattern: `AppRoutes.screenName`

### State Management
- Controllers extend `GetxController`
- Use `.obs` for reactive variables
- Update UI with `update()` or reactive variables
- Access controllers with `Get.find<ControllerName>()`

### Responsive Design
- Use `ScreenUtil` for all sizing: `.w`, `.h`, `.sp`
- Design size: 428x926 (iPhone 13 Pro Max)
- Example: `16.sp` for font size, `20.w` for width, `10.h` for height

### API Calls
- Use `ApiService` singleton for HTTP requests
- Handle responses with `ApiResponseModel`
- Log API calls with `pretty_dio_logger`

### Assets
- Images in `assets/images/`
- Icons in `assets/icons/`
- Reference in code via constants: `AppImages.imageName`, `AppIcons.iconName`

## Best Practices

- Keep screens lightweight - move logic to controllers
- Use common components for consistency
- Follow clean architecture separation of concerns
- Use dependency injection for all controllers
- Handle loading states in controllers
- Use try-catch with extensions for error handling
- Keep models immutable where possible
- Use const constructors when possible for performance

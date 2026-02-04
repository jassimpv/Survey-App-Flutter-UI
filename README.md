# collect

A new Flutter project.

## Features

- State management with [GetX](https://pub.dev/packages/get)
- Persistent storage using [shared_preferences](https://pub.dev/packages/shared_preferences)
- Network connectivity checks via [connectivity_plus](https://pub.dev/packages/connectivity_plus)
- Localization support with [flutter_localizations](https://docs.flutter.dev/accessibility-and-localization/internationalization)
- In-app updates using [upgrader](https://pub.dev/packages/upgrader)
- Loading indicators from [flutter_spinkit](https://pub.dev/packages/flutter_spinkit)
- PIN input fields with [pin_code_fields](https://pub.dev/packages/pin_code_fields)
- SVG support via [flutter_svg](https://pub.dev/packages/flutter_svg)
- Enhanced dropdowns using [dropdown_button2](https://pub.dev/packages/dropdown_button2)
- Internationalization with [intl](https://pub.dev/packages/intl)
- URL launching via [url_launcher](https://pub.dev/packages/url_launcher)
- App info retrieval with [package_info_plus](https://pub.dev/packages/package_info_plus)

## Assets

- Icons: `assets/icons/`
- Flags: `assets/flags/`
- Images: `assets/images/`
- Dummy data: `assets/dummy/`
  > **Note:** The `assets/dummy/` folder is only used during development and can be removed or left empty when the app is complete.

## Fonts

Uses the [Outfit](https://fonts.google.com/specimen/Outfit) font family with multiple weights.

## Project Structure

```
lib/
├── main.dart              # Application entry point
├── routes.dart            # Route definitions
├── core/                  # Core functionality shared across features
│   ├── constants/         # App-wide constants
│   ├── extensions/        # Dart/Flutter extensions
│   ├── localization/      # Localization setup
│   ├── models/            # Shared data models
│   ├── theme/             # Theme colors and service
│   ├── utils/             # Utility functions and helpers
│   └── widgets/           # Reusable UI widgets (BottomNavigationView, etc.)
├── features/              # Feature modules
│   ├── initial_bindings.dart  # GetX bindings initialization
│   ├── home/              # Home feature
│   ├── login/             # Login feature
│   ├── profile/           # Profile feature
│   ├── notifications/     # Notifications feature
│   ├── collection_data/   # Data collection feature
│   └── splash/            # Splash screen feature
└── test/                  # Tests
```

## State Management with GetX

This project uses **GetX** for state management, dependency injection, and navigation. Key patterns include:

### Controllers

Controllers extend `GetxController` and manage business logic:

```dart
class MyController extends GetxController {
  final RxInt count = 0.obs;

  void increment() => count.value++;
}
```

### Bindings

Bindings register controllers and dependencies:

```dart
class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyController());
  }
}
```

### Reactive UI

Use `Obx()` or `GetBuilder()` to rebuild only when observables change:

```dart
Obx(() => Text('Count: ${controller.count}')),
```

### Navigation

Simple, type-safe navigation:

```dart
Get.to(() => const HomePage());
Get.offAll(() => const SplashScreen());
```

## Components

### BottomNavigationView

A custom bottom navigation bar with GetX-based state management featuring:

- Smooth animations (slide, fade, scale transitions)
- Reactive selected state
- Pressure/pointer event handling
- Gradient styling with theme support

**Usage:**

```dart
BottomNavigationView(
  selectedIndex: 0,
  onItemClick: (index) => handleNavigation(index),
)
```

## Getting Started

1. **Install Flutter**: Ensure Flutter is installed on your system.

2. **Clone the repository**:

   ```bash
   git clone <repository-url>
   cd Survey-App-Flutter-UI
   ```

3. **Install dependencies**:

   ```bash
   flutter pub get
   ```

4. **Run the app**:

   ```bash
   flutter run
   ```

5. **Run tests**:
   ```bash
   flutter test
   ```

For more information on getting started with Flutter:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
- [GetX Documentation](https://github.com/jonataslaw/getx)

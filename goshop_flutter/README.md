# GoShop Flutter

A multi-platform e-commerce application built with Flutter, supporting iOS, Android, Web, Windows, Linux, and macOS with full screen reader accessibility.

## Features

### Core Functionality
- **Authentication**: User registration, login, and password management
- **Product Browsing**: Browse products with pagination and infinite scroll
- **Shopping Cart**: Add products to cart with quantity management
- **Order Management**: Place orders, view order history, and cancel orders
- **User Profile**: View profile information and manage account settings

### Accessibility
- **Screen Reader Support**: Full semantic labels for all UI elements
- **Keyboard Navigation**: Complete keyboard support on desktop platforms
- **Live Regions**: Screen reader announcements for state changes
- **High Contrast**: Support for system high contrast modes
- **Touch Targets**: Minimum 48x48 touch targets for all interactive elements

## Prerequisites

- Flutter SDK (3.9.0 or higher)
- Dart SDK
- For iOS development: Xcode
- For Android development: Android Studio
- For desktop development: Platform-specific build tools

## Installation

1. **Clone the repository**
   ```bash
   cd goshop_flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure backend URL**
   The app is configured to connect to `http://localhost:8888/api/v1`
   Update `lib/config/api_config.dart` if your backend runs on a different URL.

## Running the Application

### Mobile (iOS/Android)
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android
```

### Web
```bash
flutter run -d chrome
```

### Desktop
```bash
# Windows
flutter run -d windows

# Linux
flutter run -d linux

# macOS
flutter run -d macos
```

## Backend Setup

The app requires the GoShop backend to be running. Start the backend using Docker:

```bash
# From the root goshop directory
docker-compose up
```

The backend will be available at `http://localhost:8888`

## Project Structure

```
lib/
├── config/          # API configuration
├── models/          # Data models
├── services/        # API services
├── providers/       # State management (Provider)
├── screens/         # UI screens
│   ├── auth/        # Authentication screens
│   ├── products/    # Product screens
│   ├── orders/      # Order screens
│   └── profile/     # Profile screens
└── widgets/         # Reusable widgets
```

## Accessibility Testing

### Mobile
- **iOS**: Enable VoiceOver in Settings > Accessibility
- **Android**: Enable TalkBack in Settings > Accessibility

### Desktop
- **Windows**: Use Windows Narrator (Win + Ctrl + Enter)
- **Linux**: Use Orca screen reader
- **macOS**: Use VoiceOver (Cmd + F5)

### Web
- **NVDA** (Windows): Free screen reader
- **JAWS** (Windows): Commercial screen reader
- **VoiceOver** (macOS): Built-in screen reader

## Key Dependencies

- **provider**: State management
- **go_router**: Navigation and routing
- **http**: HTTP client for API calls
- **flutter_secure_storage**: Secure token storage
- **shared_preferences**: Local data persistence
- **intl**: Internationalization and number formatting

## API Integration

The app integrates with the following GoShop API endpoints:

### Authentication
- `POST /api/v1/auth/login` - User login
- `POST /api/v1/auth/register` - User registration
- `GET /api/v1/auth/me` - Get current user
- `PUT /api/v1/auth/change-password` - Change password

### Products
- `GET /api/v1/products` - List products (with pagination)
- `GET /api/v1/products/:id` - Get product details

### Orders
- `GET /api/v1/orders` - List user orders
- `GET /api/v1/orders/:id` - Get order details
- `POST /api/v1/orders` - Place new order
- `PUT /api/v1/orders/:id/cancel` - Cancel order

## Building for Production

### Mobile
```bash
# iOS
flutter build ios

# Android
flutter build apk
flutter build appbundle
```

### Web
```bash
flutter build web
```

### Desktop
```bash
# Windows
flutter build windows

# Linux
flutter build linux

# macOS
flutter build macos
```

## Troubleshooting

### Connection Issues
- Ensure the backend is running on port 8888
- Check firewall settings
- For mobile emulators, use `10.0.2.2:8888` (Android) or `localhost:8888` (iOS)

### Build Issues
- Run `flutter clean` and `flutter pub get`
- Check Flutter version: `flutter --version`
- Update Flutter: `flutter upgrade`

## License

MIT License - See the main GoShop repository for details.

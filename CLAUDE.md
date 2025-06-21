# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter news aggregation application called "Dasi-Stand" (formerly "could_be") that presents news articles with bias analysis and allows users to explore different perspectives on issues.

## Common Development Commands

### Build and Development
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter clean` - Clean build artifacts
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies

### Code Generation
- `dart run build_runner build` - Generate JSON serialization code for DTOs
- `dart run flutter_launcher_icons` - Generate app icons
- `dart run flutter_native_splash:create` - Generate splash screen

### Analysis and Testing
- `flutter analyze` - Run static analysis
- `flutter test` - Run unit tests
- `flutter test test/widget_test.dart` - Run specific test file

## Architecture

### Clean Architecture Structure
The app follows Clean Architecture with clear separation of concerns:

- **Presentation Layer** (`lib/presentation/`): UI components, views, and view models
- **Domain Layer** (`lib/domain/`): Business logic, entities, use cases, and repository interfaces
- **Data Layer** (`lib/data/`): DTOs, repository implementations, and data sources

### Key Architectural Components

#### Navigation
- Uses **go_router** for declarative routing
- Main navigation configured in `lib/core/routes/router.dart`
- Bottom navigation with 5 tabs: Home, Topic, Blind Spot, Media, My Page
- Route names centralized in `lib/core/routes/route_names.dart`

#### Dependency Injection
- Manual DI setup in `lib/core/di/use_case/use_case.dart`
- Uses **Dio** HTTP client for API communication
- Repository pattern with interfaces in domain layer

#### State Management
- Uses **GetX** for state management (see `get: ^4.7.2` in pubspec.yaml)
- View models handle business logic and state

### Core Features
1. **Feed View**: Main news feed with issue cards
2. **Shorts View**: Short-form content for specific issues
3. **Blind Spot**: Analysis of media bias and coverage gaps
4. **Media Tracking**: Subscribed media sources and bias analysis
5. **Topic Exploration**: Topic-based news browsing

### Data Flow
1. Use cases (`lib/domain/useCases/`) orchestrate business logic
2. Repository implementations (`lib/data/repositoryImpl/`) handle API calls
3. DTOs (`lib/data/dto/`) define API response structures with JSON serialization
4. Entities (`lib/domain/entities/`) represent business objects

## Key Libraries and Tools

### UI/UX
- **google_fonts** for typography
- **fl_chart** for data visualization
- **shimmer** for loading states
- **card_swiper** for swipeable cards
- **flutter_svg** for vector graphics

### Network & Authentication
- **dio** for HTTP requests
- **firebase_auth** and **google_sign_in** for authentication
- **url_launcher** for external links

### Development Tools
- **json_annotation** and **json_serializable** for JSON serialization
- **build_runner** for code generation
- **flutter_lints** for code quality

## Important Notes

### File Structure Patterns
- Components are organized by feature in `lib/presentation/`
- Shared UI components in `lib/core/components/`
- Business logic separated into use cases and repository interfaces
- Network models use `.g.dart` generated files for JSON serialization

### Code Generation Requirements
- Run `dart run build_runner build` after modifying DTO classes
- DTOs must be annotated with `@JsonSerializable()` for code generation

### Testing
- Widget tests in `test/widget_test.dart`
- Uses standard Flutter testing framework

### Theme and Styling
- Custom theme configuration in `lib/core/themes/`
- Color scheme defined in `lib/ui/color.dart`
- Typography styles in `lib/ui/fonts.dart`
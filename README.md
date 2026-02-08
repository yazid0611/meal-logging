# Meal Logging

A comprehensive Flutter application for tracking meal ingredients and nutritional information. This project uses clean architecture principles combined with modern Flutter development practices.

# Overview

Meal Logging is a cross-platform mobile application that allows users to:
- Log meals and their ingredients
- Track nutritional information (calories, macros, etc.)
- Manage ingredient databases
- View detailed nutrition statistics

The app is built with a focus on code maintainability, scalability, and separation of concerns.

# Architecture

This project implements **Clean Architecture** with the following layers:

# **Core Layer** (`lib/core/`)
Contains fundamental functionality shared across the entire application:
- **`constants/`** - Application-wide constants
- **`di/`** - Dependency injection setup using GetIt
- **`errors/`** - Custom error classe
- **`navigation/`** - Go Router configuration for navigation
- **`network/`** - Network/API client configuration
- **`theme/`** - Material Design theme definitions
- **`utils/`** - Utility functions and helpers

# **Data Layer** (`lib/data/`)
Handles all data operations and repository implementations:
- **`models/`** - Data models that map API responses and local data
- **`repositories/`** - Repository implementations (implements domain repositories)
- **`sources/`** - Data sources (local and remote API calls)

# **Domain Layer** (`lib/domain/`)
Contains business logic and use cases:
- **`entities/`** - Core domain entities independent of data sources
- **`repositories/`** - Repository interfaces (abstract contracts)
- **`usecases/`** - Business logic and use case implementations

# **Presentation Layer** (`lib/presentation/`)
Handles UI and user interaction:
- **`bloc/`** - BLoC state management classes for different features
- **`pages/`** - Full screen pages/routes
- **`widgets/`** - Reusable UI components and widgets

# Tech Stack

**Framework** | Flutter 3.10.7+ |
**Language** | Dart 3.10.7+ |
**State Management** | Flutter BLoC & Equatable | flutter_bloc - equatable
**Dependency Injection** | GetIt | get_it
**Networking** | Dio | dio
**Routing** | Go Router | go_router
**Functional Programming** | Dartz (Either/Result types) | dartz
**Utilities** | Intl (internationalization), Google Fonts | intl


# Prerequisites

- Flutter SDK >= 3.10.7
- Dart SDK >= 3.10.7
- Android SDK (for Android development)
- Xcode (for iOS development)

# Installation

1. **Clone the repository**
   ```bash
   git clone <https://github.com/yazid0611/meal-logging.git>
   cd meal_logging
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For debug mode
   flutter run

   # For specific platform
   flutter run -d android
   flutter run -d ios
   ```

## 📁 Project Structure

```
lib/
├── main.dart                 # Entry point
├── core/
│   ├── constants/           # App constants
│   ├── di/                  # Dependency injection
│   ├── errors/              # Error handling
│   ├── navigation/          # Routing
│   ├── network/             # API client
│   ├── theme/               # Theme configuration
│   └── utils/               # Utility functions
├── data/
│   ├── models/              # Data models
│   ├── repositories/        # Repository implementations
│   └── sources/             # Data sources (API, local)
├── domain/
│   ├── entities/            # Core domain entities
│   ├── repositories/        # Repository interfaces
│   └── usecases/            # Business logic
└── presentation/
    ├── bloc/                # State management (IngredientsBloc, NutritionBloc)
    ├── pages/               # Full pages
    └── widgets/             # Reusable components
```

# 🔄 Data Flow

```
UI (Pages/Widgets)
    ↓
BLoC (State Management)
    ↓
UseCases (Business Logic)
    ↓
Repositories (Abstract interfaces)
    ↓
Data Sources (API/Local)
    ↓
Models ↔ Entities
```

# 📦 Key Features

### State Management (BLoC)
- **IngredientsBloc** - Manages ingredient-related state
- **NutritionBloc** - Manages nutrition tracking state

### Dependency Injection
Uses GetIt service locator for clean dependency management:
```dart
configureDependencies(); // Called in main()
```

### Error Handling
Implements functional error handling using Dartz `Either` type for type-safe error management.

### Internationalization
Uses Intl package for date formatting.

## 📝 Development Guidelines

### Adding a New Feature

1. Create entity in `domain/entities/`
2. Create repository interface in `domain/repositories/`
3. Create use case in `domain/usecases/`
4. Create data model in `data/models/`
5. Implement repository in `data/repositories/`
6. Create data source in `data/sources/`
7. Create BLoC in `presentation/bloc/`
8. Create UI pages/widgets in `presentation/`

## API Endpoints

 `/v4/ingredients` | POST | Analyze meal and get ingredients |
 `/v5/nutrients/micro` | POST | Get detailed nutrition info |

## 👥 Team

- **Developers** - [Yazid El Amel]


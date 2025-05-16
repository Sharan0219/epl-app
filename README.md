# Exam Prep App

A sophisticated Flutter application for exam preparation with daily challenges.

## Features

- Sleek, modern UI with smooth animations
- Phone number authentication
- User profile setup with image upload
- Daily challenges with various question types
- Interactive game room with timer and audio
- Dashboard with statistics and activity tracking

## Tech Stack

- **Flutter**: Cross-platform UI framework
- **GetX**: State management, dependency injection, and routing
- **Firebase**: Authentication, storage, and database
- **Animations**: Using flutter_animate and animated_text_kit

## Prerequisites

To run this project, you'll need:

1. **Flutter SDK** - [Install Flutter](https://flutter.dev/docs/get-started/install)
2. **Android Studio** or **VS Code** with Flutter extensions
3. **Firebase Account** for backend services

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/exam_prep_app.git
cd exam_prep_app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up Firebase

1. Create a new Firebase project in the [Firebase Console](https://console.firebase.google.com/)
2. Add Android and iOS apps to your Firebase project
3. Download the Firebase configuration files:
   - `google-services.json` for Android (place in `android/app/`)
   - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
4. Enable Authentication with Phone Number sign-in method
5. Set up Firestore Database with the following collections:
   - `users`
   - `challenges`
   - `questions`

### 4. Run the app

```bash
flutter run
```

## Project Structure

The project follows a modular architecture:

- **core/**: Contains core functionality (routes, services, theme, utils)
- **modules/**: Feature modules (splash, auth, profile, dashboard, game_room)
- **models/**: Data models
- **widgets/**: Reusable UI components

## Customization

### Theme and Colors

Modify the app's appearance by editing:
- `lib/core/theme/app_colors.dart`: Color palette
- `lib/core/theme/app_theme.dart`: Theme configuration

### Adding New Question Types

To add new question types:
1. Update the `QuestionModel` class
2. Create a new component in `lib/modules/game_room/components/`
3. Update the `QuestionCard` to handle the new type

## Future Enhancements

- Leaderboard system
- More question types (drag & drop, matching, etc.)
- Offline mode
- Dark/Light theme toggle
- Performance analytics
- Social sharing

## License

This project is licensed under the MIT License - see the LICENSE file for details.
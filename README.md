# Matching Game (Matchy Match) V.1

**Matching Game** is a Flutter-based memory card matching game designed for Android and iOS. Test your memory speed and pattern recognition skills by finding all matching character pairs before the 60-second timer runs out!

---

> **Note**: The customization feature is currently under development and will be available in a future update.

## Features & Highlights

- **60-Second Challenge**: Race against the clock to match all 8 pairs (16 cards total) in 60 seconds or less.
- **3D Card Flip Animations**: Smooth card flipping animations powered by Flutter `AnimationController` and `Matrix4` 3D perspective transforms.
- **Custom Theme & Material 3**: Complete Material Design 3 support with light and dark mode color palettes.
- **Multi-Screen Flow**:
  - **Splash Screen**: Initial loading display introducing the game.
  - **Main Menu**: Options to launch into gameplay or exit.
  - **Game Board**: Interactive 4x4 card grid featuring custom artwork.
- **Game State & Dialogs**: Win and Loss modal alerts with options to replay or return to the menu.

---

## Gameplay Overview

1. Launch the app and tap **Start Game** from the main menu.
2. Tap any card on the 4x4 grid to flip it face up and reveal the hidden character artwork.
3. Tap a second card:
   - **Match!** If both cards match, they stay face up.
   - **Mismatch!** If the cards don't match, they briefly remain visible for 1 second before flipping back down.
4. Match all 8 pairs before the **60-second timer** expires to win!

---

## Project Structure

```text
lib/
├── components/
│   └── theme.dart          # Material 3 light/dark theme definitions and color scheme
├── screens/
│   ├── splash_screen.dart  # Animated splash screen transition
│   ├── menu_screen.dart    # Main menu with start and exit options
│   └── game_screen.dart    # 4x4 grid gameplay, timer logic, & 3D flip animation
└── main.dart               # Main app entry point & MaterialApp configuration
```

---

## Getting Started

### Prerequisites

Ensure you have the following installed on your developer machine:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.13.4` or later)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / Xcode (for device emulators/simulators)

### Installation & Execution

1. **Clone or navigate into the project directory:**
   ```bash
   cd matchymatch
   ```

2. **Fetch Flutter package dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app on a connected device or emulator:**
   ```bash
   flutter run
   ```

---

## Testing & Code Quality

Run tests and static analysis with the Flutter toolchain:

```bash
# Run unit and widget tests
flutter test

# Run code analysis & linter checks
flutter analyze
```

---

## License

This project is created for demonstration and entertainment purposes.

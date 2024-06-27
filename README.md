# Weekend Countdown

A Flutter project for displaying a live countdown to the next weekend (Thursday at 3 PM GST).

## Description

This Flutter app displays the current date and time, the date and time of the next weekend, and a dynamic countdown showing the remaining time until the next weekend starts.

## Features

- Live display of the current date and time.
- Countdown to the next weekend (Thursday at 3 PM GST).
- Custom digital font for the countdown display.

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/weekend_countdown.git
   cd weekend_countdown
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

### Running the App

To run the app on a connected device or emulator:
```sh
flutter run
```

### Building for Web

To build the app for the web:
```sh
flutter build web
```
The output will be located in the `build/web` directory.

## Project Structure

```
weekend_countdown/
├── android/
├── assets/
│   └── fonts/
│       └── digital-7/
│           ├── digital-7 (mono).ttf
├── build/
├── ios/
├── lib/
│   ├── main.dart
├── test/
├── pubspec.yaml
└── README.md
```

## Fonts

The app uses the `digital-7 (mono).ttf` font for the countdown display. The font is located in the `assets/fonts/digital-7/` directory.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Digital-7 Font](https://www.dafont.com/digital-7.font) by Style-7
- [Flutter](https://flutter.dev)
- [Intl Package](https://pub.dev/packages/intl)

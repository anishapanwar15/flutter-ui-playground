# Flutter UI Playground

A Flutter project for exploring and experimenting with various UI components and design patterns.

## Features
- Beautiful UI components
- Reusable widgets
- Modern Flutter development practices

## Getting Started

### Prerequisites
- Flutter SDK installed
- Dart SDK (comes with Flutter)

### Installation
```bash
git clone https://github.com/anishapanwar15/flutter-ui-playground.git
cd flutter-ui-playground
flutter pub get
```

### Running the App
```bash
flutter run
```

## Project Structure
- `/lib` - Main application code
- `/lib/widgets` - Reusable UI widgets
- `/lib/screens` - App screens

## Code Examples

### Basic Widget Example
```dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
```

### Using the Widget
```dart
CustomButton(
  label: 'Click Me',
  onPressed: () {
    print('Button pressed!');
  },
)
```

### Stateful Widget Example
```dart
class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count: $_count'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            },
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
}
```

## Tips & Best Practices
- Use `const` constructors where possible for performance
- Keep widgets small and focused on a single responsibility
- Use proper state management (Provider, Riverpod, GetX, etc.)
- Test your widgets with `flutter test`

## Troubleshooting

### Build Issues
```bash
flutter clean
flutter pub get
flutter run
```

### Dependency Issues
```bash
flutter pub upgrade
flutter pub get
```

## Contributing
Feel free to fork this repository and submit pull requests for any improvements!

## License
This project is open source and available under the MIT License.

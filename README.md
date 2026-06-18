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

## Widget Showcase

### 1. Custom Card Widget
```dart
class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;

  const CustomCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Animated Button Widget
```dart
class AnimatedCustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const AnimatedCustomButton({
    required this.label,
    required this.onPressed,
  });

  @override
  State<AnimatedCustomButton> createState() => _AnimatedCustomButtonState();
}

class _AnimatedCustomButtonState extends State<AnimatedCustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        onPressed: () {
          _controller.forward().then((_) {
            _controller.reverse();
          });
          widget.onPressed();
        },
        child: Text(widget.label),
      ),
    );
  }
}
```

### 3. Custom List Tile Widget
```dart
class CustomListTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData leadingIcon;
  final VoidCallback onTap;

  const CustomListTile({
    required this.title,
    required this.description,
    required this.leadingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Icon(leadingIcon, size: 32, color: Colors.blueAccent),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
```

### 4. Gradient Button Widget
```dart
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Gradient gradient;

  const GradientButton({
    required this.label,
    required this.onPressed,
    this.gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 5. Loading Widget with Animation
```dart
class LoadingWidget extends StatefulWidget {
  final String message;

  const LoadingWidget({this.message = 'Loading...'});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _controller,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.message,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
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

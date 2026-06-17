import 'package:flutter/material.dart';

// Color management constants
class AppColors {
  static const Color primary = Colors.indigo;
  static const Color primaryDark = Color(0xFF1A237E);
  static const Color primaryLight = Color(0xFFE8EAF6);
  
  static const List<Color> cardGradient = [
    Color(0xFF3F51B5),
    Color(0xFF5C6BC0),
    Color(0xFF7986CB),
    Color(0xFF9FA8DA),
    Color(0xFFC5CAE9),
  ];
  
  static Color getCardColor(int index) {
    return cardGradient[index % cardGradient.length];
  }
}

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      10,
      (index) => AnimationController(
        duration: Duration(milliseconds: 600 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();

    // Start animations sequentially
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout'),
        backgroundColor: AppColors.primary,
        elevation: 4,
      ),
      body: isMobile
          ? _buildMobileLayout()
          : isTablet
              ? _buildTabletLayout()
              : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          5,
          (index) => _buildAnimatedCard(
            index: index,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.getCardColor(index),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.getCardColor(index).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Card ${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      padding: const EdgeInsets.all(12),
      itemCount: 9,
      itemBuilder: (context, index) {
        return _buildAnimatedCard(
          index: index,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.getCardColor(index),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.getCardColor(index).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Item ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildAnimatedCard(
          index: index,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.getCardColor(index),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.getCardColor(index).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Item ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedCard({
    required int index,
    required Widget child,
  }) {
    return ScaleTransition(
      scale: _animations[index % _animations.length],
      child: FadeTransition(
        opacity: _animations[index % _animations.length],
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }
}

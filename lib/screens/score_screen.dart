import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ScoreScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Score'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          TweenAnimationBuilder(
            duration: const Duration(seconds: 3),
            curve: Curves.easeOutBack,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, double value, child) {
              final startY = screenHeight - 100;
              final endY = screenHeight * 0.25;
              final currentY = startY + (endY - startY) * value;
              final scale = 0.2 + (0.8 * value);
              final opacity = value.clamp(0.0, 1.0);

              return Positioned(
                left: screenWidth / 2 - (50 * scale),
                top: currentY - (50 * scale),
                child: Opacity(
                  opacity: opacity,
                  child: Transform.scale(
                    scale: scale,
                    child: Icon(
                      Icons.emoji_events,
                      size: 100,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              );
            },
          ),


          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Congratulations!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Your Score:',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(
                  '$score / 40',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                        'Home',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 18,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:quizapp/models/models.dart';

class AnswerOption extends StatelessWidget {
  final Option option;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color? backgroundColor;
    if (isSelected) {
      backgroundColor = isCorrect ? Colors.green : Colors.red;
    } else if (isCorrect) {
      backgroundColor = Colors.green;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.colorScheme.surface,
          border: Border.all(
            color: theme.colorScheme.onSurface.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          option.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: backgroundColor != null ? Colors.white : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class HeartIndicator extends StatelessWidget {
  final int fullHearts;
  final bool hasHalfHeart;
  final int maxHearts;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  
  const HeartIndicator({
    Key? key,
    required this.fullHearts,
    this.hasHalfHeart = false,
    this.maxHearts = 5,
    this.onIncrement,
    this.onDecrement,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onDecrement != null)
          IconButton(
            icon: Icon(Icons.remove_circle_outline, size: 20),
            onPressed: onDecrement,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        SizedBox(width: 8),
        ...List.generate(maxHearts, (index) {
          if (index < fullHearts) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.favorite,
                color: AppTheme.heartRed,
                size: 24,
              ),
            );
          } else if (index == fullHearts && hasHalfHeart) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.favorite,
                color: AppTheme.heartRed.withOpacity(0.5),
                size: 24,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(
                Icons.favorite_border,
                color: AppTheme.heartEmpty,
                size: 24,
              ),
            );
          }
        }),
        SizedBox(width: 8),
        if (onIncrement != null)
          IconButton(
            icon: Icon(Icons.add_circle_outline, size: 20),
            onPressed: onIncrement,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
      ],
    );
  }
}
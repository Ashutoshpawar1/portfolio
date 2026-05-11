import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AnimatedSectionTitle extends StatelessWidget {
  final String title;

  const AnimatedSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double fontSize = width < 420
              ? 54
              : (width < 720 ? 76 : (width < 1100 ? 104 : 132));

          return Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppColors.white.withOpacity(0.08),
                  fontSize: fontSize,
                  letterSpacing: 0,
                  height: 0.95,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

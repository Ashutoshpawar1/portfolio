import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class TopMenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const TopMenuButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isMenu = label == "MENU";

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p20,
          vertical: AppSizes.p12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.divider),
          color: Colors.black.withOpacity(0.25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isMenu) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 18, height: 1.6, color: AppColors.white),
                  const SizedBox(height: 4),
                  Container(width: 18, height: 1.6, color: AppColors.white),
                ],
              ),
              const SizedBox(width: 12),
            ],
            Text(label, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}

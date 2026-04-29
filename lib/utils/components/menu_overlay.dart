import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_sizes.dart';
import 'top_menu_button.dart';

class MenuOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const MenuOverlay({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: AppColors.black.withOpacity(0.94),
            ).animate().fadeIn(duration: 400.ms),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: TopMenuButton(label: AppStrings.close, onTap: onClose),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMenuItem(context, AppStrings.home, 0),
                _buildMenuItem(context, AppStrings.aboutMe, 1),
                _buildMenuItem(context, AppStrings.projects, 2),
                _buildMenuItem(context, AppStrings.playground, 3),
                _buildMenuItem(context, AppStrings.contact, 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String label, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.p12),
      child: InkWell(
        onTap: onClose,
        child:
            Text(
                  label,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 56,
                  ),
                )
                .animate()
                .fadeIn(delay: (200 + index * 100).ms, duration: 400.ms)
                .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
      ),
    );
  }
}

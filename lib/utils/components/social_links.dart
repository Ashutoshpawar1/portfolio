import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(Icons.link, 'LinkedIn'),
        const SizedBox(width: 20),
        _buildSocialIcon(Icons.terminal, 'GitHub'),
        const SizedBox(width: 20),
        _buildSocialIcon(Icons.alternate_email, 'Email'),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white.withOpacity(0.03),
            border: Border.all(color: AppColors.divider),
          ),
          child: Icon(icon, color: AppColors.white, size: 24),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../services/external_link_service.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(Icons.link, 'LinkedIn', AppStrings.linkedinUrl),
        const SizedBox(width: 20),
        _buildSocialIcon(Icons.terminal, 'GitHub', AppStrings.githubUrl),
        const SizedBox(width: 20),
        _buildSocialIcon(Icons.alternate_email, 'Email', AppStrings.emailUrl),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String tooltip, String url) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => openExternalUrl(url),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withValues(alpha: 0.03),
              border: Border.all(color: AppColors.divider),
            ),
            child: Icon(icon, color: AppColors.white, size: 24),
          ),
        ),
      ),
    );
  }
}

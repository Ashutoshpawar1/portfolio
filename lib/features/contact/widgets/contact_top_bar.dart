import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/premium_button.dart';

class ContactTopBar extends StatelessWidget {
  final VoidCallback onClose;
  final bool isCompact;

  const ContactTopBar({super.key, required this.onClose, required this.isCompact});

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppStrings.logoText,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 38,
                  color: Colors.white.withOpacity(0.82),
                ),
              ),
              const Spacer(),
              PremiumButton(
                label: "CLOSE",
                onTap: onClose,
                isPrimary: false,
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 14,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _ContactStatusChip(),
              _ContactMetaBlock(title: "LOCAL TIME", value: "1:32 PM"),
              _ContactMetaBlock(title: "ZONE", value: "GMT+7"),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          AppStrings.logoText,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: 56,
            color: Colors.white.withOpacity(0.82),
          ),
        ),
        const Spacer(),
        const _ContactStatusChip(),
        const SizedBox(width: 28),
        const _ContactMetaBlock(title: "LOCAL TIME", value: "1:32 PM"),
        const SizedBox(width: 28),
        const _ContactMetaBlock(title: "ZONE", value: "GMT+7"),
        const SizedBox(width: 20),
        PremiumButton(
          label: "CLOSE",
          onTap: onClose,
          isPrimary: false,
        ),
      ],
    );
  }
}

class _ContactStatusChip extends StatelessWidget {
  const _ContactStatusChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
        color: AppColors.white.withOpacity(0.03),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 10, color: AppColors.emerald),
          SizedBox(width: 8),
          Text(
            "Available for project",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactMetaBlock extends StatelessWidget {
  final String title;
  final String value;

  const _ContactMetaBlock({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

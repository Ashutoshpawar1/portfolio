import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/premium_button.dart';
import 'live_time_widget.dart';

class ContactTopBar extends StatelessWidget {
  final VoidCallback onClose;
  final bool isCompact;

  const ContactTopBar({
    super.key,
    required this.onClose,
    required this.isCompact,
  });

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
              PremiumButton(label: "CLOSE", onTap: onClose, isPrimary: false),
            ],
          ),
          const SizedBox(height: 18),
          const Wrap(
            spacing: 14,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [_ContactStatusChip(), LiveTimeWidget(isCompact: true)],
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
        const LiveTimeWidget(isCompact: false),
        const SizedBox(width: 20),
        PremiumButton(label: "CLOSE", onTap: onClose, isPrimary: false),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _PulsingGreenDot(),
          const SizedBox(width: 8),
          Text(
            "Available for Freelance",
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

class _PulsingGreenDot extends StatefulWidget {
  const _PulsingGreenDot();

  @override
  State<_PulsingGreenDot> createState() => _PulsingGreenDotState();
}

class _PulsingGreenDotState extends State<_PulsingGreenDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.35, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.emerald.withOpacity(
                  0.3 * (1.0 - _pulseAnimation.value),
                ),
              ),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.emerald,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emerald.withOpacity(
                      0.5 * _pulseAnimation.value,
                    ),
                    blurRadius: 6 * _pulseAnimation.value,
                    spreadRadius: 2 * _pulseAnimation.value,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

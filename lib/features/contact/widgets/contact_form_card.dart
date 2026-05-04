import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/components/premium_button.dart';

class ContactFormCard extends StatelessWidget {
  final bool isCompact;

  const ContactFormCard({super.key, required this.isCompact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isCompact ? 18 : 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          isCompact
              ? const Column(
                  children: [
                    _ContactInput(hint: "Enter your name"),
                    SizedBox(height: 16),
                    _ContactInput(hint: "Email"),
                  ],
                )
              : const Row(
                  children: [
                    Expanded(child: _ContactInput(hint: "Enter your name")),
                    SizedBox(width: 18),
                    Expanded(child: _ContactInput(hint: "Email")),
                  ],
                ),
          const SizedBox(height: 18),
          const _ContactInput(hint: "Message", minLines: 4, maxLines: 5),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final bool stacked = constraints.maxWidth < 520;

              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "By submitting you agree to our Terms of Service and Privacy Policy",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PremiumButton(
                      label: "SUBSCRIBE",
                      onTap: () {},
                      isPrimary: false,
                      icon: Icons.north_east,
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      "By submitting you agree to our Terms of Service and Privacy Policy",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 14,
                        height: 1.45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  PremiumButton(
                    label: "SUBSCRIBE",
                    onTap: () {},
                    isPrimary: false,
                    icon: Icons.north_east,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ContactInput extends StatelessWidget {
  final String hint;
  final int minLines;
  final int maxLines;

  const _ContactInput({
    required this.hint,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: minLines,
      maxLines: maxLines,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.28),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: AppColors.black,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF5A36)),
        ),
      ),
    );
  }
}

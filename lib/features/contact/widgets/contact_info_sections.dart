import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'contact_form_card.dart';

class ContactHeadlineBlock extends StatelessWidget {
  final bool isCompact;

  const ContactHeadlineBlock({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "(CONTACT US)",
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "LET'S\nWORK\nTOGETHER",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isCompact ? 74 : 120,
            color: Colors.white.withOpacity(0.82),
            height: 0.88,
          ),
        ),
        const SizedBox(height: 28),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isCompact ? 520 : 460),
          child: const Text(
            "Have a project in mind? We'd love to hear about it. Let's create something great together.",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 18,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ContactFormAndInfo extends StatelessWidget {
  final bool isCompact;

  const ContactFormAndInfo({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactFormCard(isCompact: isCompact),
        const SizedBox(height: 30),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            Text(
              "Prefer to hop on a call?",
              style: TextStyle(
                color: Colors.white.withOpacity(0.65),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              "Book a call",
              style: TextStyle(
                color: Color(0xFFFF5A36),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "instead.",
              style: TextStyle(
                color: Colors.white.withOpacity(0.65),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Container(height: 1, color: AppColors.divider),
        const SizedBox(height: 30),
        const Text(
          "Visit Us",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 28),
        isCompact
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoColumn(
                    label: "(ADDRESS)",
                    value: "123 Market Street,\nSuite 400\nLos Angeles, CA 90001",
                  ),
                  SizedBox(height: 24),
                  InfoColumn(
                    label: "(OFFICE HOURS)",
                    value: "Monday - Friday\n9:00 AM - 6:00 PM (GMT+7)",
                  ),
                ],
              )
            : const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InfoColumn(
                      label: "(ADDRESS)",
                      value: "123 Market Street,\nSuite 400\nLos Angeles, CA 90001",
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: InfoColumn(
                      label: "(OFFICE HOURS)",
                      value: "Monday - Friday\n9:00 AM - 6:00 PM (GMT+7)",
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const InfoColumn({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            height: 1.18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

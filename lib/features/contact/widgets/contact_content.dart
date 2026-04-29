import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/premium_button.dart';
import '../../../utils/components/site_footer.dart';

class ContactContent extends StatelessWidget {
  final VoidCallback onClose;

  const ContactContent({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final bool isCompact = constraints.maxWidth < 980;
          final bool isMobile = constraints.maxWidth < 720;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              isCompact ? (isMobile ? 18 : 24) : 32,
              isMobile ? 18 : 24,
              isCompact ? (isMobile ? 18 : 24) : 32,
              40,
            ),
            child: Column(
              children: [
                _ContactTopBar(onClose: onClose, isCompact: isCompact),
                SizedBox(height: isMobile ? 28 : 48),
                isCompact
                    ? const _MobileContactBody()
                    : const _DesktopContactBody(),
                SizedBox(height: isMobile ? 38 : 54),
                SiteFooter(compactBrand: isCompact),
              ],
            ),
          );
      },
    );
  }
}

class _ContactTopBar extends StatelessWidget {
  final VoidCallback onClose;
  final bool isCompact;

  const _ContactTopBar({required this.onClose, required this.isCompact});

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

class _DesktopContactBody extends StatelessWidget {
  const _DesktopContactBody();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(flex: 10, child: _ContactHeadlineBlock()),
        SizedBox(width: 64),
        Expanded(flex: 11, child: _ContactFormAndInfo()),
      ],
    );
  }
}

class _MobileContactBody extends StatelessWidget {
  const _MobileContactBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactHeadlineBlock(isCompact: true),
        SizedBox(height: 36),
        _ContactFormAndInfo(isCompact: true),
      ],
    );
  }
}

class _ContactHeadlineBlock extends StatelessWidget {
  final bool isCompact;

  const _ContactHeadlineBlock({this.isCompact = false});

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

class _ContactFormAndInfo extends StatelessWidget {
  final bool isCompact;

  const _ContactFormAndInfo({this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactFormCard(isCompact: isCompact),
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
                  _InfoColumn(
                    label: "(ADDRESS)",
                    value: "123 Market Street,\nSuite 400\nLos Angeles, CA 90001",
                  ),
                  SizedBox(height: 24),
                  _InfoColumn(
                    label: "(OFFICE HOURS)",
                    value: "Monday - Friday\n9:00 AM - 6:00 PM (GMT+7)",
                  ),
                ],
              )
            : const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _InfoColumn(
                      label: "(ADDRESS)",
                      value: "123 Market Street,\nSuite 400\nLos Angeles, CA 90001",
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: _InfoColumn(
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

class _ContactFormCard extends StatelessWidget {
  final bool isCompact;

  const _ContactFormCard({required this.isCompact});

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

class _InfoColumn extends StatelessWidget {
  final String label;
  final String value;

  const _InfoColumn({required this.label, required this.value});

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

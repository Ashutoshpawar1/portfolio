import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';

class SiteFooter extends StatelessWidget {
  final bool compactBrand;

  const SiteFooter({super.key, this.compactBrand = false});

  @override
  Widget build(BuildContext context) {
    return _FooterBrandBand(compact: compactBrand);
  }
}

class _FooterContent extends StatelessWidget {
  const _FooterContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.black,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 44),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool compact = constraints.maxWidth < 980;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              compact
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FooterContactBlock(),
                        SizedBox(height: 32),
                        _FooterLinksWrap(),
                        SizedBox(height: 32),
                        _FooterNewsletter(),
                        SizedBox(height: 28),
                        _FooterBottomRow(compact: true),
                      ],
                    )
                  : const Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 6, child: _FooterContactBlock()),
                            Expanded(flex: 5, child: _FooterLinksWrap()),
                            Expanded(flex: 5, child: _FooterNewsletter()),
                          ],
                        ),
                        SizedBox(height: 36),
                        _FooterBottomRow(),
                      ],
                    ),
            ],
          );
        },
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.08, end: 0);
  }
}

class _FooterContactBlock extends StatelessWidget {
  const _FooterContactBlock();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterInfoRow(
          label: "(EMAIL)",
          value: AppStrings.emailAddress,
          accent: true,
        ),
        SizedBox(height: 22),
        _FooterInfoRow(label: "(GITHUB)", value: "Ashutoshpawar1"),
      ],
    );
  }
}

class _FooterInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool accent;

  const _FooterInfoRow({
    required this.label,
    required this.value,
    this.accent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: accent ? const Color(0xFFFF5A36) : AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _FooterLinksWrap extends StatelessWidget {
  const _FooterLinksWrap();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _FooterLinkColumn(
            title: "(LINKS)",
            links: ["Home", "About", "Works", "Contact", "Blog", "Waitlist"],
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: _FooterLinkColumn(
            title: "(SOCIALS)",
            links: ["X/Twitter", "Instagram", "LinkedIn", "Behance"],
            external: true,
          ),
        ),
      ],
    );
  }
}

class _FooterLinkColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  final bool external;

  const _FooterLinkColumn({
    required this.title,
    required this.links,
    this.external = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 14),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _FooterHoverLink(label: link, external: external),
            )),
      ],
    );
  }
}

class _FooterHoverLink extends StatefulWidget {
  final String label;
  final bool external;

  const _FooterHoverLink({required this.label, this.external = false});

  @override
  State<_FooterHoverLink> createState() => _FooterHoverLinkState();
}

class _FooterHoverLinkState extends State<_FooterHoverLink> {
  bool _hovered = false;

  double get _underlineWidth {
    final double estimate = widget.label.length * 12.0;
    return estimate.clamp(54.0, 150.0);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: _underlineWidth + (widget.external ? 28 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 220),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                  child: Text(widget.label),
                ),
                if (widget.external) ...[
                  const SizedBox(width: 8),
                  Text(
                    "↗",
                    style: TextStyle(
                      color: _hovered ? const Color(0xFFFF5A36) : AppColors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              height: 1.5,
              width: _hovered ? _underlineWidth : 0,
              color: const Color(0xFFFF5A36),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterNewsletter extends StatelessWidget {
  const _FooterNewsletter();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sign up for our newsletter to\nget latest insights and updates",
          style: TextStyle(
            color: Colors.white.withOpacity(0.88),
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 34),
        Text(
          "Enter email address",
          style: TextStyle(
            color: Colors.white.withOpacity(0.62),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(height: 1, color: AppColors.divider),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.divider),
          ),
          child: const Center(
            child: Text(
              "SUBSCRIBE",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterBottomRow extends StatelessWidget {
  final bool compact;

  const _FooterBottomRow({this.compact = false});

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "©2025 ASHUTOSH. ALL RIGHTS RESERVED",
            style: TextStyle(color: AppColors.grey, fontSize: 14),
          ),
          SizedBox(height: 10),
          Text(
            "Privacy Policy • Terms of Service",
            style: TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ],
      );
    }

    return const Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "©2025 ASHUTOSH. ALL RIGHTS RESERVED",
              style: TextStyle(color: AppColors.grey, fontSize: 14),
            ),
            SizedBox(height: 10),
            Text(
              "Privacy Policy • Terms of Service",
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ],
        ),
        Spacer(),
        Text(
          "MADE BY ASHUTOSH",
          style: TextStyle(color: AppColors.white, fontSize: 15),
        ),
      ],
    );
  }
}

class _FooterBrandBand extends StatelessWidget {
  final bool compact;

  const _FooterBrandBand({required this.compact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFF5536),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 20 : 28,
        vertical: compact ? 34 : 46,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool stacked = compact || constraints.maxWidth < 1100;

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ASHUTOSH",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 110,
                    color: Colors.black,
                    height: 0.88,
                  ),
                ),
                const SizedBox(height: 22),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Beyond\nVisuals.\nBuilt with\nVision.",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 46,
                    ),
                  ),
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  "ASHUTOSH",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 190,
                    color: Colors.black,
                    height: 0.84,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Beyond\nVisuals.\nBuilt with\nVision.",
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 54,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ).animate().fadeIn(duration: 550.ms).slideY(begin: 0.12, end: 0);
  }
}

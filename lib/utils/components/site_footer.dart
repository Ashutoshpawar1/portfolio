import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SiteFooter extends StatelessWidget {
  final bool compactBrand;

  const SiteFooter({super.key, this.compactBrand = false});

  @override
  Widget build(BuildContext context) {
    return _FooterBrandBand(compact: compactBrand);
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
                  "ASHUTOSH\nGARGE",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 94,
                    color: Colors.black,
                    height: 0.88,
                  ),
                ),
                const SizedBox(height: 18),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Text(
                    "Flutter Developer focused on scalable applications, real-time communication systems, and AI-powered digital experiences.",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black.withValues(alpha: 0.82),
                      fontSize: 22,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "© 2026 Ashutosh. All rights reserved.",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  "ASHUTOSH\nGARGE",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 156,
                    color: Colors.black,
                    height: 0.84,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Flutter Developer focused on scalable applications, real-time communication systems, and AI-powered digital experiences.",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black.withValues(alpha: 0.82),
                          fontSize: 24,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "© 2026 Ashutosh. All rights reserved.",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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

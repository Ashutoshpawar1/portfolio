import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_sizes.dart';
import '../../controllers/home_controller.dart';
import 'top_menu_button.dart';

class MenuOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final Future<void> Function(HomeSection section) onNavigate;

  const MenuOverlay({
    super.key,
    required this.onClose,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final List<({String label, HomeSection section})> menuItems = [
      (label: AppStrings.home, section: HomeSection.home),
      (label: AppStrings.aboutMe, section: HomeSection.about),
      (label: AppStrings.projectSection, section: HomeSection.projects),
      (label: AppStrings.skills, section: HomeSection.skills),
      (label: AppStrings.experience, section: HomeSection.experience),
      (label: AppStrings.tools, section: HomeSection.tools),
    ];

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
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 96,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: menuItems
                      .asMap()
                      .entries
                      .map(
                        (entry) => _buildMenuItem(
                          context,
                          entry.value.label,
                          entry.value.section,
                          entry.key,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String label,
    HomeSection section,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.p12),
      child: _OverlayMenuItem(
        label: label,
        onTap: () => onNavigate(section),
      )
          .animate()
          .fadeIn(delay: (200 + index * 100).ms, duration: 400.ms)
          .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
    );
  }
}

class _OverlayMenuItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _OverlayMenuItem({required this.label, required this.onTap});

  @override
  State<_OverlayMenuItem> createState() => _OverlayMenuItemState();
}

class _OverlayMenuItemState extends State<_OverlayMenuItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth < 640 ? 38 : 56;
    final TextStyle baseStyle = Theme.of(context).textTheme.displayMedium!.copyWith(
      fontSize: fontSize,
      color: _hovered ? AppColors.orange : AppColors.white,
    );
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.label, style: baseStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    final double underlineWidth = textPainter.width;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: baseStyle,
              child: Text(widget.label, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: underlineWidth,
              height: 2,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _hovered ? 1 : 0),
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: value,
                      alignment: Alignment.centerLeft,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  height: 2,
                  color: const Color(0xFFFF5A36),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

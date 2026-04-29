import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class PremiumButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final IconData? icon;

  const PremiumButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isPrimary = true,
    this.icon,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -4.0 : 0.0),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_isHovered ? const Color(0xFFE4E4E4) : AppColors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: widget.isPrimary ? Colors.transparent : AppColors.divider,
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 20,
                  color: widget.isPrimary ? AppColors.black : AppColors.white,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  letterSpacing: 0.3,
                  color: widget.isPrimary ? AppColors.black : AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

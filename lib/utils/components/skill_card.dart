import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class SkillCard extends StatefulWidget {
  final String skill;
  final IconData icon;

  const SkillCard({super.key, required this.skill, required this.icon});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  double _x = 0;
  double _y = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _x = (event.localPosition.dx - 75) / 75;
          _y = (event.localPosition.dy - 75) / 75;
        });
      },
      onExit: (_) => setState(() {
        _x = 0;
        _y = 0;
      }),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.01)
          ..rotateX(_y * 0.2)
          ..rotateY(-_x * 0.2),
        alignment: Alignment.center,
        child: Container(
          width: 150,
          height: 150,
          margin: const EdgeInsets.all(AppSizes.p12),
          decoration: BoxDecoration(
            color: AppColors.darkGrey,
            borderRadius: BorderRadius.circular(AppSizes.r20),
            border: Border.all(color: AppColors.orange.withAlpha(77)),
            boxShadow: [
              if (_x != 0)
                BoxShadow(
                  color: AppColors.orange.withAlpha(51),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: AppColors.orange, size: 40),
              const SizedBox(height: AppSizes.p12),
              Text(
                widget.skill,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().scale();
  }
}

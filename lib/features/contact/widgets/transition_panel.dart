import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../constants/app_strings.dart';

class TransitionPanel extends StatelessWidget {
  final Animation<double> animation;
  final Color color;
  final String label;

  const TransitionPanel({
    super.key,
    required this.animation,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> slide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1.1),
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    return SlideTransition(
      position: slide,
      child: Container(
        color: color,
        child: label.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 44,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool compact = constraints.maxWidth < 900;

                    if (compact) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  color: Colors.black.withOpacity(0.92),
                                  fontSize: 110,
                                  height: 0.9,
                                ),
                          ),
                          const SizedBox(height: 26),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Beyond\nVisuals.\nBuilt with\nVision.",
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 42,
                                  ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 280.ms);
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            label,
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  color: Colors.black.withOpacity(0.92),
                                  fontSize: 190,
                                  height: 0.84,
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Beyond\nVisuals.\nBuilt with\nVision.",
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 54,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 280.ms);
                  },
                ),
              ),
      ),
    );
  }
}

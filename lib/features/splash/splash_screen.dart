import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../routes/app_router.dart';
import '../../utils/components/brand_transition_panels.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _loaderController;
  late Animation<double> _loaderAnimation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _loaderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _loaderController, curve: Curves.easeInOutCubic),
    );

    _loaderController.addListener(() {
      setState(() {});
    });

    _loaderController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isLoading = false;
        });
      }
    });

    _loaderController.forward();
  }

  @override
  void dispose() {
    _loaderController.dispose();
    super.dispose();
  }

  String _getLoadingText(double value) {
    if (value < 0.2) return "INITIALIZING ENGINE";
    if (value < 0.45) return "OPTIMIZING GRAPHICS";
    if (value < 0.7) return "LOADING PORTFOLIO SHADERS";
    if (value < 0.9) return "COMPILING ASSETS";
    return "READY";
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      final double progress = _loaderAnimation.value;
      final int percentage = (progress * 100).toInt();

      return Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            // Linear Progress line at the very top
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 4,
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5A36),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFFF5A36),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Center number counter
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getLoadingText(progress),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.35),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        percentage.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          color: Color(0xFFFF5A36),
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "%",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.2),
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // After loading, trigger the existing BrandTransitionOverlay
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BrandTransitionOverlay(
        label: AppStrings.logoText,
        onComplete: () {
          if (context.mounted) {
            context.go(AppRouter.home);
          }
        },
      ),
    );
  }
}

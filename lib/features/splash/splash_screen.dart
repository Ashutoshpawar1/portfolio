import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../routes/app_router.dart';
import '../../utils/components/brand_transition_panels.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

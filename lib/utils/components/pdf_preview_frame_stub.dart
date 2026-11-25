import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class PdfPreviewFrame extends StatelessWidget {
  final String pdfUrl;

  const PdfPreviewFrame({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF5A36).withValues(alpha: 0.12),
                border: Border.all(
                  color: const Color(0xFFFF5A36).withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.picture_as_pdf_rounded,
                color: Color(0xFFFF5A36),
                size: 34,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Ashutosh Garge — Resume',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Flutter Developer (3+ Years Experience)\nAndroid • iOS • Web • Firebase • Clean Architecture',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFFF5A36),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Tap "Download PDF" below to view & save the full resume.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

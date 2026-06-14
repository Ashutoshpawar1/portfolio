import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../services/external_link_service.dart';
import 'pdf_preview_frame.dart';
import 'premium_button.dart';

class ResumePreviewDialog extends StatelessWidget {
  const ResumePreviewDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (_) => const ResumePreviewDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isCompact = width < 900;
    final String pdfUrl = Uri.base.resolve(AppStrings.resumeWebPath).toString();

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isCompact ? 16 : 40,
        vertical: isCompact ? 20 : 32,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: isCompact ? double.infinity : 980,
        height: isCompact ? 640 : 760,
        padding: EdgeInsets.all(isCompact ? 18 : 24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resume Preview',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Review the PDF first, then download it from here.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.68),
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: AppColors.white),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    border: Border.all(color: AppColors.divider),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: PdfPreviewFrame(pdfUrl: pdfUrl),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: PremiumButton(
                label: 'Download PDF',
                icon: Icons.download_rounded,
                onTap: () => downloadFile(pdfUrl, 'ashutosh_resume.pdf'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

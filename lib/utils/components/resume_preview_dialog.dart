import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../services/external_link_service.dart';
import 'pdf_preview_frame.dart';
import 'premium_button.dart';

class ResumePreviewDialog extends StatelessWidget {
  const ResumePreviewDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Resume Preview Modal',
      barrierColor: Colors.black.withValues(alpha: 0.82),
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (context, anim1, anim2) {
        return const MouseRegion(
          cursor: SystemMouseCursors.basic,
          opaque: true,
          child: ResumePreviewDialog(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return MouseRegion(
          cursor: SystemMouseCursors.basic,
          opaque: true,
          child: FadeTransition(
            opacity: anim1,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.96, end: 1.0).animate(
                CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isCompact = width < 900;
    final String pdfUrl = Uri.base.resolve(AppStrings.resumeWebPath).toString();

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          Navigator.of(context).maybePop();
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        opaque: true,
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isCompact ? 16 : 40,
            vertical: isCompact ? 18 : 32,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Container(
            width: isCompact ? double.infinity : 980,
            height:
                isCompact ? (screenHeight * 0.86).clamp(420.0, 720.0) : 760,
            padding: EdgeInsets.all(isCompact ? 16 : 24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.divider),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 32,
                  offset: const Offset(0, 16),
                ),
              ],
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
                              fontSize: isCompact ? 20 : 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Review the PDF first, then download it from here.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.68),
                              fontSize: isCompact ? 12.5 : 14,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Tooltip(
                      message: 'Close Preview (Esc)',
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(24),
                            hoverColor: Colors.white.withValues(alpha: 0.15),
                            splashColor: Colors.white.withValues(alpha: 0.25),
                            highlightColor: Colors.white.withValues(alpha: 0.10),
                            onTap: () => Navigator.of(context).maybePop(),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.08),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.18),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
        ),
      ),
    );
  }
}

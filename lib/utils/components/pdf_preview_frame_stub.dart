import 'package:flutter/material.dart';

class PdfPreviewFrame extends StatelessWidget {
  final String pdfUrl;

  const PdfPreviewFrame({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Resume preview is available on the web version of this portfolio.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

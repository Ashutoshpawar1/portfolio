// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

class PdfPreviewFrame extends StatefulWidget {
  final String pdfUrl;

  const PdfPreviewFrame({super.key, required this.pdfUrl});

  @override
  State<PdfPreviewFrame> createState() => _PdfPreviewFrameState();
}

class _PdfPreviewFrameState extends State<PdfPreviewFrame> {
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'resume-preview-${widget.pdfUrl.hashCode}-${identityHashCode(this)}';
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return html.IFrameElement()
        ..src = widget.pdfUrl
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allowFullscreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}

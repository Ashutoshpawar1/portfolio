// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

Future<void> openExternalUrl(String url) async {
  html.window.open(url, '_blank');
}

Future<void> downloadFile(String url, String fileName) async {
  final html.AnchorElement anchor =
      html.AnchorElement(href: url)
        ..download = fileName
        ..style.display = 'none';

  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}

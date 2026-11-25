import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternalUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

Future<void> downloadFile(String url, String fileName) async {
  try {
    List<int>? bytes;
    try {
      final ByteData data =
          await rootBundle.load('lib/assets/resume/$fileName');
      bytes = data.buffer.asUint8List();
    } catch (_) {}

    if (bytes != null && bytes.isNotEmpty) {
      Directory dir;
      if (Platform.isAndroid) {
        dir = (await getExternalStorageDirectory()) ??
            await getApplicationDocumentsDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      final File file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);

      final Uri fileUri = Uri.file(file.path);
      if (await canLaunchUrl(fileUri)) {
        await launchUrl(fileUri, mode: LaunchMode.externalApplication);
        return;
      }
    }

    final Uri webUri = Uri.parse(url);
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    }
  } catch (_) {
    try {
      final Uri webUri = Uri.parse(url);
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }
}


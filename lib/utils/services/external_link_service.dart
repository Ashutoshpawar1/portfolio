import 'external_link_service_stub.dart'
    if (dart.library.html) 'external_link_service_web.dart' as impl;

Future<void> openExternalUrl(String url) => impl.openExternalUrl(url);

Future<void> downloadFile(String url, String fileName) =>
    impl.downloadFile(url, fileName);

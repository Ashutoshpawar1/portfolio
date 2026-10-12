/// Configuration for EmailJS service.
///
/// You can configure these credentials in two ways:
/// 1. Directly in this file by updating the [publicKey] defaultValue below.
/// 2. Via Flutter compile-time environment variables (`--dart-define`):
///    `flutter run -d chrome --dart-define=EMAILJS_PUBLIC_KEY=your_public_key`
class EmailJsConfig {
  /// Your EmailJS Service ID.
  static const String serviceId = String.fromEnvironment(
    'EMAILJS_SERVICE_ID',
    defaultValue: 'service_1niy1us',
  );

  /// Your EmailJS Template ID.
  static const String templateId = String.fromEnvironment(
    'EMAILJS_TEMPLATE_ID',
    defaultValue: 'template_cgren67',
  );

  /// Your EmailJS Public Key (Found in EmailJS Dashboard > Account > API Keys > Public Key).
  /// Replace 'YOUR_EMAILJS_PUBLIC_KEY' with your actual key.
  static const String publicKey = String.fromEnvironment(
    'EMAILJS_PUBLIC_KEY',
    defaultValue: 'xlJFNSh9fprLZ1xef',
  );

  /// Your recipient name displayed in the email template.
  static const String recipientName = 'Ashutosh';

  /// Your email inbox where inquiries will arrive.
  static const String recipientEmail = 'ashutoshgarge123@gmail.com';

  /// Official EmailJS REST API endpoint.
  static const String endpoint = 'https://api.emailjs.com/api/v1.0/email/send';

  /// Checks whether real EmailJS credentials have been set.
  static bool get isConfigured {
    return serviceId.isNotEmpty &&
        serviceId != 'YOUR_SERVICE_ID' &&
        serviceId != 'service_1niy1us' &&
        templateId.isNotEmpty &&
        templateId != 'YOUR_TEMPLATE_ID' &&
        templateId != 'template_cgren67' &&
        publicKey.isNotEmpty &&
        publicKey != 'YOUR_EMAILJS_PUBLIC_KEY' &&
        publicKey != 'YOUR_PUBLIC_KEY';
  }
}

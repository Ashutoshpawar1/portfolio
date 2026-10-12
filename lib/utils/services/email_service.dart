import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/emailjs_config.dart';

/// Result wrapper for EmailJS dispatch.
class EmailSendResult {
  final bool isSuccess;
  final String message;

  const EmailSendResult({required this.isSuccess, required this.message});
}

/// Service to handle email dispatch via EmailJS REST API.
class EmailService {
  EmailService._();
  static final EmailService instance = EmailService._();

  DateTime? _lastSubmitTime;
  static const Duration _cooldownDuration = Duration(seconds: 15);

  /// Dispatches the user inquiry to EmailJS.
  Future<EmailSendResult> sendContactEmail({
    required String name,
    required String email,
    required String message,
    String honeypot = '',
  }) async {
    // 1. Spam protection: Honeypot check
    // If a bot filled out the hidden honeypot field, quietly succeed without delivering
    if (honeypot.trim().isNotEmpty) {
      return const EmailSendResult(
        isSuccess: true,
        message: 'Message sent successfully!',
      );
    }

    // 2. Spam protection: Client-side rate-limiting cooldown
    final now = DateTime.now();
    if (_lastSubmitTime != null &&
        now.difference(_lastSubmitTime!) < _cooldownDuration) {
      final remaining =
          _cooldownDuration.inSeconds -
          now.difference(_lastSubmitTime!).inSeconds;
      return EmailSendResult(
        isSuccess: false,
        message:
            'Please wait $remaining seconds before submitting another inquiry.',
      );
    }

    // 3. Verification of configuration
    if (!EmailJsConfig.isConfigured) {
      return const EmailSendResult(
        isSuccess: false,
        message:
            'EmailJS credentials are not configured yet. Please configure your Service ID and Template ID in lib/constants/emailjs_config.dart.',
      );
    }

    // 4. Dispatch REST request to EmailJS
    try {
      final payload = {
        'service_id': EmailJsConfig.serviceId,
        'template_id': EmailJsConfig.templateId,
        'user_id': EmailJsConfig.publicKey,
        'template_params': {
          // Exact matches for the user's template variables:
          'name': name.trim(),
          'email': email.trim(),
          'message': message.trim(),
          // Standard EmailJS aliases for reply_to and headers:
          'reply_to': email.trim(),
          'from_name': name.trim(),
          'from_email': email.trim(),
          'to_name': EmailJsConfig.recipientName,
          'to_email': EmailJsConfig.recipientEmail,
          'timestamp': DateTime.now().toLocal().toString().split('.').first,
        },
      };

      final response = await http
          .post(
            Uri.parse(EmailJsConfig.endpoint),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        _lastSubmitTime = DateTime.now();
        return const EmailSendResult(
          isSuccess: true,
          message:
              'Thank you! Your message has been sent successfully. I will get back to you soon.',
        );
      } else {
        final bodyText = response.body.trim();
        return EmailSendResult(
          isSuccess: false,
          message: bodyText.isNotEmpty
              ? 'Email service response: $bodyText'
              : 'Failed to deliver message (status code: ${response.statusCode}). Please try again.',
        );
      }
    } catch (e) {
      return const EmailSendResult(
        isSuccess: false,
        message:
            'Unable to connect to the email service. Please check your internet connection or email directly.',
      );
    }
  }
}

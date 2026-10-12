import 'package:flutter_test/flutter_test.dart';
import 'package:ashu_portfolio/constants/app_strings.dart';
import 'package:ashu_portfolio/constants/emailjs_config.dart';
import 'package:ashu_portfolio/utils/services/email_service.dart';

void main() {
  group('WhatsApp Integration Tests', () {
    test(
      'WhatsApp number is properly formatted without +, spaces, or dashes',
      () {
        expect(AppStrings.whatsappNumber, equals('919131246012'));
        expect(AppStrings.whatsappNumber.contains('+'), isFalse);
        expect(AppStrings.whatsappNumber.contains(' '), isFalse);
        expect(AppStrings.whatsappNumber.contains('-'), isFalse);
      },
    );

    test('WhatsApp greeting is prefilled and properly URL encoded', () {
      final url = AppStrings.whatsappUrl;
      expect(url.startsWith('https://wa.me/919131246012?text='), isTrue);
      expect(
        url.contains(Uri.encodeComponent(AppStrings.whatsappGreeting)),
        isTrue,
      );
      expect(url.contains('Hello'), isTrue);
      expect(url.contains('portfolio'), isTrue);
    });
  });

  group('EmailJS Service & Config Tests', () {
    test('Honeypot blocks bots silently without errors', () async {
      final result = await EmailService.instance.sendContactEmail(
        name: 'Bot User',
        email: 'bot@spam.com',
        message: 'Spam message',
        honeypot: 'filled_by_bot',
      );

      expect(result.isSuccess, isTrue);
    });

    test('Unconfigured credentials return clear, actionable message', () async {
      if (!EmailJsConfig.isConfigured) {
        final result = await EmailService.instance.sendContactEmail(
          name: 'Ashutosh',
          email: 'test@example.com',
          message: 'Hello, this is a test message of sufficient length.',
        );

        expect(result.isSuccess, isFalse);
        expect(result.message.contains('not configured'), isTrue);
      }
    });
  });
}

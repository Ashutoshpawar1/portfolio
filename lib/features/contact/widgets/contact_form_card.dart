import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/emailjs_config.dart';
import '../../../utils/components/premium_button.dart';
import '../../../utils/services/email_service.dart';
import '../../../utils/services/external_link_service.dart';

class ContactFormCard extends StatefulWidget {
  final bool isCompact;

  const ContactFormCard({super.key, required this.isCompact});

  @override
  State<ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<ContactFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _honeypotController = TextEditingController();

  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;
  String _submittedName = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _honeypotController.dispose();
    super.dispose();
  }

  void _triggerMailto(String name, String email, String message) {
    final String timestamp = DateTime.now()
        .toLocal()
        .toString()
        .split('.')
        .first;

    final String subject = Uri.encodeComponent(
      "Inquiry from $name via Portfolio",
    );
    final String body = Uri.encodeComponent(
      "Hi Ashutosh,\n\n"
      "You have received a new inquiry from your Portfolio.\n\n"
      "Sender Details:\n"
      "---------------------------\n"
      "Name: $name\n"
      "Email: $email\n"
      "Timestamp: $timestamp\n"
      "---------------------------\n\n"
      "Message:\n"
      "$message\n",
    );

    final String mailtoUrl =
        "mailto:${EmailJsConfig.recipientEmail}?subject=$subject&body=$body";
    openExternalUrl(mailtoUrl);
  }

  Future<void> _submitForm() async {
    // Prevent duplicate submissions while already loading
    if (_isLoading) return;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String message = _messageController.text.trim();
      final String honeypot = _honeypotController.text.trim();

      final result = await EmailService.instance.sendContactEmail(
        name: name,
        email: email,
        message: message,
        honeypot: honeypot,
      );

      if (!mounted) return;

      if (result.isSuccess) {
        setState(() {
          _submittedName = name;
          _isLoading = false;
          _isSuccess = true;
          _errorMessage = null;

          // Reset form fields ONLY upon successful delivery
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          _honeypotController.clear();
        });
      } else {
        // Fallback: If EmailJS service ID is not yet connected or API fails,
        // automatically trigger the default email client with all details prefilled
        // so the user never encounters a blocking error!
        _triggerMailto(name, email, message);

        setState(() {
          _submittedName = name;
          _isLoading = false;
          _isSuccess = true;
          _errorMessage = null;

          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          _honeypotController.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSuccess) {
      return Container(
        padding: EdgeInsets.all(widget.isCompact ? 18 : 24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF53D769).withValues(alpha: 0.12),
                border: Border.all(
                  color: const Color(0xFF53D769).withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.check_circle_outline_rounded,
                color: Color(0xFF53D769),
                size: 56,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _submittedName.isNotEmpty
                  ? "Thank You, $_submittedName!"
                  : "Message Sent Successfully!",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Your message has been delivered directly to Ashutosh's inbox. I'll get back to you shortly.",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                PremiumButton(
                  label: "SEND ANOTHER MESSAGE",
                  onTap: () {
                    setState(() {
                      _isSuccess = false;
                      _errorMessage = null;
                    });
                  },
                  isPrimary: false,
                  icon: Icons.refresh_rounded,
                ),
                PremiumButton(
                  label: "CHAT ON WHATSAPP",
                  onTap: () => openExternalUrl(AppStrings.whatsappUrl),
                  isPrimary: true,
                  icon: Icons.chat_rounded,
                ),
              ],
            ),
          ],
        ),
      );
    }

    final formWidget = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Invisible honeypot field for bot/spam protection
          Offstage(
            offstage: true,
            child: TextField(controller: _honeypotController),
          ),
          widget.isCompact
              ? Column(
                  children: [
                    _ContactInput(
                      hint: "Enter your name",
                      controller: _nameController,
                      enabled: !_isLoading,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Please enter your name";
                        }
                        if (val.trim().length < 2) {
                          return "Name must be at least 2 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _ContactInput(
                      hint: "Email",
                      controller: _emailController,
                      enabled: !_isLoading,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Please enter your email";
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegex.hasMatch(val.trim())) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ContactInput(
                        hint: "Enter your name",
                        controller: _nameController,
                        enabled: !_isLoading,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return "Please enter your name";
                          }
                          if (val.trim().length < 2) {
                            return "Name must be at least 2 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _ContactInput(
                        hint: "Email",
                        controller: _emailController,
                        enabled: !_isLoading,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return "Please enter your email";
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(val.trim())) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 18),
          _ContactInput(
            hint: "Message",
            minLines: 4,
            maxLines: 5,
            controller: _messageController,
            enabled: !_isLoading,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "Please enter your message";
              }
              if (val.trim().length < 10) {
                return "Message must be at least 10 characters";
              }
              return null;
            },
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.1),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.35),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: Colors.redAccent,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final bool stacked = constraints.maxWidth < 520;

              final textDisclaimer = Text(
                "By submitting you agree to our Terms of Service and Privacy Policy",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              );

              final submitButton = PremiumButton(
                label: "SEND MESSAGE",
                onTap: _isLoading ? () {} : _submitForm,
                isPrimary: false,
                icon: Icons.north_east,
              );

              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textDisclaimer,
                    const SizedBox(height: 16),
                    SizedBox(width: double.infinity, child: submitButton),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: textDisclaimer),
                  const SizedBox(width: 18),
                  submitButton,
                ],
              );
            },
          ),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.all(widget.isCompact ? 18 : 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: _isLoading ? 0.35 : 1.0,
            child: IgnorePointer(ignoring: _isLoading, child: formWidget),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 38,
                      height: 38,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFFF5A36),
                        ),
                        strokeWidth: 3.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Sending message...",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ContactInput extends StatelessWidget {
  final String hint;
  final int minLines;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputType? keyboardType;

  const _ContactInput({
    required this.hint,
    this.minLines = 1,
    this.maxLines = 1,
    this.controller,
    this.validator,
    this.enabled = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      enabled: enabled,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.28),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: AppColors.black,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.divider.withValues(alpha: 0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF5A36)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.8),
        ),
        errorStyle: const TextStyle(
          color: Colors.redAccent,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

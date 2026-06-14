import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import 'glass_container.dart';
import 'premium_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 900;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isCompact ? 24 : 50,
            vertical: 100,
          ),
          child: isCompact
              ? Column(
                  children: [
                    _buildForm(context),
                    const SizedBox(height: 40),
                    _buildInfo(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _buildForm(context)),
                    const SizedBox(width: 50),
                    Expanded(child: _buildInfo()),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send a Message",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Tell me about your app, redesign, or product idea.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          _buildTextField("Name"),
          const SizedBox(height: 20),
          _buildTextField("Email"),
          const SizedBox(height: 20),
          _buildTextField("Message", maxLines: 5),
          const SizedBox(height: 40),
          PremiumButton(label: "Send Message", onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactItem(Icons.email_outlined, "Email", AppStrings.email),
        const SizedBox(height: 24),
        _buildContactItem(Icons.phone_outlined, "WhatsApp", "+91 1234567890"),
        const SizedBox(height: 24),
        _buildContactItem(Icons.location_on_outlined, "Location", "India"),
      ],
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          style: TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white.withOpacity(0.04),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.divider),
          ),
          child: Icon(icon, color: AppColors.white),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: AppColors.white.withOpacity(0.5)),
            ),
            Text(
              value,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

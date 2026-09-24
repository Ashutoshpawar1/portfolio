import 'package:flutter/material.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../contact/widgets/contact_info_sections.dart';

class ContactMeSection extends StatelessWidget {
  const ContactMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isCompact = width < 980;
    final bool isMobile = width < 720;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: isCompact ? (isMobile ? 18 : 40) : 60,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: "Contact Me"),
          const SizedBox(height: 64),
          isCompact
              ? const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactHeadlineBlock(isCompact: true),
                    SizedBox(height: 36),
                    ContactFormAndInfo(isCompact: true),
                  ],
                )
              : const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 10, child: ContactHeadlineBlock()),
                    SizedBox(width: 64),
                    Expanded(flex: 11, child: ContactFormAndInfo()),
                  ],
                ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../utils/components/site_footer.dart';
import 'contact_top_bar.dart';
import 'contact_info_sections.dart';

class ContactContent extends StatelessWidget {
  final VoidCallback onClose;

  const ContactContent({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < 980;
        final bool isMobile = constraints.maxWidth < 720;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            isCompact ? (isMobile ? 18 : 24) : 32,
            isMobile ? 18 : 24,
            isCompact ? (isMobile ? 18 : 24) : 32,
            40,
          ),
          child: Column(
            children: [
              ContactTopBar(onClose: onClose, isCompact: isCompact),
              SizedBox(height: isMobile ? 28 : 48),
              isCompact
                  ? const _MobileContactBody()
                  : const _DesktopContactBody(),
              SizedBox(height: isMobile ? 38 : 54),
              SiteFooter(compactBrand: isCompact),
            ],
          ),
        );
      },
    );
  }
}

class _DesktopContactBody extends StatelessWidget {
  const _DesktopContactBody();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(flex: 10, child: ContactHeadlineBlock()),
        SizedBox(width: 64),
        Expanded(flex: 11, child: ContactFormAndInfo()),
      ],
    );
  }
}

class _MobileContactBody extends StatelessWidget {
  const _MobileContactBody();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactHeadlineBlock(isCompact: true),
        SizedBox(height: 36),
        ContactFormAndInfo(isCompact: true),
      ],
    );
  }
}

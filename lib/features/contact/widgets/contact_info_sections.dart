import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/services/external_link_service.dart';
import 'contact_form_card.dart';

class ContactHeadlineBlock extends StatelessWidget {
  final bool isCompact;

  const ContactHeadlineBlock({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "(CONTACT US)",
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "LET'S\nWORK\nTOGETHER",
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: isCompact ? 74 : 120,
            color: Colors.white.withOpacity(0.82),
            height: 0.88,
          ),
        ),
        const SizedBox(height: 28),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isCompact ? 520 : 460),
          child: Text(
            "Have a project in mind? We'd love to hear about it. Let's create something great together.",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 18,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class ContactFormAndInfo extends StatelessWidget {
  final bool isCompact;

  const ContactFormAndInfo({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactFormCard(isCompact: isCompact),
        const SizedBox(height: 30),
        Text(
          "Connect Instantly",
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _CTAButton(
              icon: Icons.calendar_today_rounded,
              label: "SCHEDULE CALL",
              onTap: () => openExternalUrl(AppStrings.scheduleCallUrl),
            ),
            _CTAButton(
              icon: Icons.email_outlined,
              label: "EMAIL ME",
              onTap: () => openExternalUrl(AppStrings.emailUrl),
            ),
            _CTAButton(
              icon: Icons.chat_bubble_outline_rounded,
              label: "WHATSAPP",
              onTap: () => openExternalUrl(AppStrings.whatsappUrl),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Container(height: 1, color: AppColors.divider),
        const SizedBox(height: 30),
        Text(
          "Contact",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 28),
        isCompact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InteractiveContactCard(
                    label: "(EMAIL)",
                    value: AppStrings.emailAddress,
                    icon: Icons.alternate_email_rounded,
                    onTap: () => openExternalUrl(AppStrings.emailUrl),
                  ),
                  const SizedBox(height: 18),
                  InteractiveContactCard(
                    label: "(LINKEDIN)",
                    value: "ashutosh-garge-3037a5240",
                    icon: Icons.share_rounded,
                    onTap: () => openExternalUrl(AppStrings.linkedinUrl),
                  ),
                  const SizedBox(height: 18),
                  InteractiveContactCard(
                    label: "(GITHUB)",
                    value: "Ashutoshpawar1",
                    icon: Icons.code_rounded,
                    onTap: () => openExternalUrl(AppStrings.githubUrl),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InteractiveContactCard(
                      label: "(EMAIL)",
                      value: AppStrings.emailAddress,
                      icon: Icons.alternate_email_rounded,
                      onTap: () => openExternalUrl(AppStrings.emailUrl),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InteractiveContactCard(
                      label: "(LINKEDIN)",
                      value: "ashutosh-garge-3037a5240",
                      icon: Icons.share_rounded,
                      onTap: () => openExternalUrl(AppStrings.linkedinUrl),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InteractiveContactCard(
                      label: "(GITHUB)",
                      value: "Ashutoshpawar1",
                      icon: Icons.code_rounded,
                      onTap: () => openExternalUrl(AppStrings.githubUrl),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

class InteractiveContactCard extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const InteractiveContactCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  State<InteractiveContactCard> createState() => _InteractiveContactCardState();
}

class _InteractiveContactCardState extends State<InteractiveContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -6, 0))
              : Matrix4.identity(),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceElevated : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFF5A36).withOpacity(0.5)
                  : AppColors.divider,
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF5A36).withOpacity(0.12),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 220),
                  opacity: _isHovered ? 1.0 : 0.4,
                  child: Icon(
                    Icons.north_east_rounded,
                    color: _isHovered ? const Color(0xFFFF5A36) : Colors.white,
                    size: 16,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.icon,
                        color: _isHovered
                            ? const Color(0xFFFF5A36)
                            : AppColors.grey,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.value,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CTAButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFF5A36)
                : AppColors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered ? const Color(0xFFFF5A36) : AppColors.divider,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF5A36).withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isHovered ? Colors.black : Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _isHovered ? Colors.black : Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

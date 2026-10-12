import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../controllers/app_cursor_controller.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/scroll_reveal.dart';
import '../../../utils/services/external_link_service.dart';

class BlogArticle {
  final String title;
  final String subtitle;
  final String description;
  final String imageAsset;
  final String url;
  final String readTime;
  final List<String> tags;

  const BlogArticle({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageAsset,
    required this.url,
    required this.readTime,
    required this.tags,
  });
}

final List<BlogArticle> _blogArticles = const [
  BlogArticle(
    title: 'Two Ways to Deploy a Flutter App on iOS: IPA vs. Xcode',
    subtitle: 'Build • Upload • TestFlight • App Store',
    description:
        'A comprehensive guide comparing the CLI-driven "flutter build ipa" approach with Xcode Organizer archiving for smooth TestFlight and App Store Connect releases.',
    imageAsset: 'lib/assets/images/blog_flutter_ios_deployment.png',
    url:
        'https://medium.com/@ashutoshgarge123/flutter-ios-deployment-ipa-vs-xcode-organizer-daa437cdb628?postPublishedType=initial',
    readTime: '4 min read',
    tags: ['Flutter', 'iOS', 'Xcode', 'Deployment'],
  ),
  BlogArticle(
    title: 'The Ultimate Guide to Naming Conventions',
    subtitle: 'Write Clean. Think Clear. Code Better.',
    description:
        'Naming conventions may seem small, but they have a massive impact on readability and team collaboration. Master naming standards for files, classes, methods, and variables.',
    imageAsset: 'lib/assets/images/blog_naming_conventions.png',
    url:
        'https://medium.com/@ashutoshgarge123/the-ultimate-guide-to-naming-conventions-01e13b44af0d',
    readTime: '5 min read',
    tags: ['Clean Code', 'Dart', 'Architecture', 'Best Practices'],
  ),
];

class BlogArticlesSection extends StatelessWidget {
  const BlogArticlesSection({super.key});

  static const String _mediumProfileUrl =
      'https://medium.com/@ashutoshgarge123';

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final bool isTablet = screenWidth >= 768 && screenWidth < 1080;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: isMobile ? 18 : 40,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: "Blog & Articles"),
          const SizedBox(height: 32),
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            from: 20,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                'Sharing insights, tutorials, and deep dives into Flutter, Dart, and Software Architecture.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grey.withValues(alpha: 0.92),
                  fontSize: isMobile ? 16 : 18,
                  height: 1.7,
                ),
              ),
            ),
          ),
          const SizedBox(height: 64),
          ScrollReveal(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: isMobile
                  ? Column(
                      children: [
                        for (int i = 0; i < _blogArticles.length; i++) ...[
                          if (i > 0) const SizedBox(height: 32),
                          FadeInUp(
                            duration: const Duration(milliseconds: 650),
                            delay: Duration(milliseconds: 150 * i),
                            from: 30,
                            child: _BlogCard(
                              article: _blogArticles[i],
                              isMobile: true,
                            ),
                          ),
                        ],
                      ],
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        final double cardWidth = isTablet
                            ? ((constraints.maxWidth - 32) / 2)
                            : ((constraints.maxWidth - 40) / 2).clamp(
                                440.0,
                                560.0,
                              );

                        return Wrap(
                          spacing: 32,
                          runSpacing: 32,
                          alignment: WrapAlignment.center,
                          children: [
                            for (int i = 0; i < _blogArticles.length; i++)
                              FadeInUp(
                                duration: const Duration(milliseconds: 650),
                                delay: Duration(milliseconds: 150 * i),
                                from: 30,
                                child: SizedBox(
                                  width: cardWidth,
                                  child: _BlogCard(
                                    article: _blogArticles[i],
                                    isMobile: false,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 56),
          ScrollReveal(child: const _ViewAllButton(url: _mediumProfileUrl)),
        ],
      ),
    );
  }
}

class _BlogCard extends StatefulWidget {
  final BlogArticle article;
  final bool isMobile;

  const _BlogCard({required this.article, required this.isMobile});

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _isHovered = false;

  void _openArticle() {
    openExternalUrl(widget.article.url);
  }

  @override
  Widget build(BuildContext context) {
    final double bannerHeight = widget.isMobile ? 190.0 : 220.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(true, label: "READ");
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(false);
        }
      },
      child: GestureDetector(
        onTap: _openArticle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _isHovered
                  ? AppColors.orange.withValues(alpha: 0.45)
                  : AppColors.glassBorder,
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered) ...[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.55),
                  blurRadius: 36,
                  spreadRadius: 2,
                  offset: const Offset(0, 18),
                ),
                BoxShadow(
                  color: AppColors.orange.withValues(alpha: 0.08),
                  blurRadius: 24,
                  spreadRadius: -2,
                  offset: const Offset(0, 6),
                ),
              ] else
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.22),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [_buildBannerImage(bannerHeight), _buildCardContent()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerImage(double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background ambient blurred fill matching banner colors
          Image.asset(
            widget.article.imageAsset,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(color: Colors.black.withValues(alpha: 0.5)),
          ),
          // Foreground crisp banner graphic
          AnimatedScale(
            scale: _isHovered ? 1.03 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Image.asset(
                widget.article.imageAsset,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          // Gradient fade into card surface
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 36,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.surface.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),
          ),
          // Top metadata chips
          Positioned(
            top: 14,
            left: 14,
            right: 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.glassBorder, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 12,
                        color: AppColors.orange.withValues(alpha: 0.9),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.article.readTime,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.9),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.glassBorder, width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.emerald,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Medium",
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.95),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent() {
    return Padding(
      padding: EdgeInsets.all(widget.isMobile ? 20.0 : 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtitle / Highlight tagline
          Text(
            widget.article.subtitle.toUpperCase(),
            style: TextStyle(
              color: AppColors.orange.withValues(alpha: 0.85),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          // Title
          Text(
            widget.article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _isHovered ? AppColors.orange : AppColors.white,
              fontSize: widget.isMobile ? 18 : 21,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            widget.article.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.grey.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.article.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.divider, width: 0.8),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: AppColors.grey.withValues(alpha: 0.95),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),
          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.divider,
          ),
          const SizedBox(height: 16),
          // Footer action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Read on Medium",
                style: TextStyle(
                  color: _isHovered ? AppColors.white : AppColors.grey,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isHovered
                      ? AppColors.orange
                      : AppColors.surfaceElevated,
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.orange
                        : AppColors.glassBorder,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_outward_rounded,
                    size: 18,
                    color: _isHovered ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewAllButton extends StatefulWidget {
  final String url;

  const _ViewAllButton({required this.url});

  @override
  State<_ViewAllButton> createState() => _ViewAllButtonState();
}

class _ViewAllButtonState extends State<_ViewAllButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(true, label: "VISIT");
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(false);
        }
      },
      child: GestureDetector(
        onTap: () => openExternalUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.surfaceElevated
                : AppColors.surface.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered
                  ? AppColors.orange.withValues(alpha: 0.5)
                  : AppColors.glassBorder,
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: AppColors.orange.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: 18,
                color: _isHovered ? AppColors.orange : AppColors.white,
              ),
              const SizedBox(width: 10),
              Text(
                "Read More on Medium",
                style: TextStyle(
                  color: _isHovered ? AppColors.orange : AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedSlide(
                offset: _isHovered ? const Offset(0.15, -0.15) : Offset.zero,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  size: 16,
                  color: _isHovered ? AppColors.orange : AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

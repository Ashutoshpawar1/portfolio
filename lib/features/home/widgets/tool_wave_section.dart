import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';

class ToolWaveSection extends StatefulWidget {
  const ToolWaveSection({super.key});

  @override
  State<ToolWaveSection> createState() => _ToolWaveSectionState();
}

class _ToolWaveSectionState extends State<ToolWaveSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loopController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 32),
  )..repeat();

  @override
  void dispose() {
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 72),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1380),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BackdropTitle(title: "TOOLS"),
              const SizedBox(height: 26),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool compact = constraints.maxWidth < 860;
                  final bool tablet = constraints.maxWidth < 1180;

                  return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(compact ? 20 : 28),
                        decoration: BoxDecoration(
                          color: const Color(0xFF171717),
                          borderRadius: BorderRadius.circular(
                            compact ? 28 : 40,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 38,
                              offset: Offset(0, 18),
                            ),
                          ],
                        ),
                        child: compact
                            ? _buildCompactLayout(constraints.maxWidth)
                            : _buildWideLayout(
                                constraints.maxWidth,
                                tablet: tablet,
                              ),
                      )
                      .animate()
                      .fadeIn(duration: 700.ms)
                      .slideY(begin: 0.08, end: 0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout(double width, {required bool tablet}) {
    final double phoneWidth = tablet ? 304 : 336;
    final double copyWidth = tablet ? 390 : 470;

    return SizedBox(
      height: tablet ? 670 : 720,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: copyWidth,
              child: _SectionCopy(
                headlineSize: tablet ? 58 : 68,
                paragraphSize: tablet ? 16 : 17,
                center: false,
              ),
            ),
          ),
          Positioned(
            left: -6,
            right: -10,
            bottom: 16,
            height: tablet ? 250 : 300,
            child: _WaveLogos(controller: _loopController, compact: false),
          ),
          Positioned(
            right: 0,
            bottom: -4,
            child: _PhoneShowcase(
              controller: _loopController,
              width: phoneWidth,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLayout(double width) {
    final bool smallPhone = width < 560;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionCopy(
          headlineSize: smallPhone ? 42 : 50,
          paragraphSize: 16,
          center: true,
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: smallPhone ? 170 : 195,
          child: _WaveLogos(controller: _loopController, compact: true),
        ),
        const SizedBox(height: 16),
        Center(
          child: _PhoneShowcase(
            controller: _loopController,
            width: smallPhone ? 266 : 292,
            compact: true,
          ),
        ),
      ],
    );
  }
}

class _BackdropTitle extends StatelessWidget {
  final String title;

  const _BackdropTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double fontSize = width < 700 ? 64 : (width < 1100 ? 96 : 126);

    return Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          color: AppColors.white.withValues(alpha: 0.08),
          fontSize: fontSize,
          letterSpacing: -3,
          height: 0.92,
        ),
      ),
    );
  }
}

class _SectionCopy extends StatelessWidget {
  final double headlineSize;
  final double paragraphSize;
  final bool center;

  const _SectionCopy({
    required this.headlineSize,
    required this.paragraphSize,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: _platforms
              .map(
                (platform) =>
                    _PlatformChip(label: platform.label, icon: platform.icon),
              )
              .toList(),
        ),
        SizedBox(height: center ? 18 : 24),
        Text(
          "Write faster in all your\napps, on any device",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.cormorantGaramond(
            color: AppColors.orange,
            fontSize: headlineSize,
            height: 0.96,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Text(
            "Seamless speech-to-text in every application on your phone or computer.",
            textAlign: center ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.84),
              fontSize: paragraphSize,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _PlatformChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PlatformChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x3DFFFFFF)),
        color: const Color(0x0DFFFFFF),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.orange),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveLogos extends StatelessWidget {
  final AnimationController controller;
  final bool compact;

  const _WaveLogos({required this.controller, required this.compact});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double waveHeight = constraints.maxHeight;
        final double waveWidth = constraints.maxWidth;
        final double badgeSize = compact ? 54 : 68;
        final double spacing = compact ? 84 : 98;
        final double arcLift = compact ? 22 : 54;
        final double baseY = compact ? waveHeight * 0.56 : waveHeight * 0.62;
        final double totalTrack = _toolBadges.length * spacing;

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final double progress = controller.value;
            final double travel = progress * totalTrack;
            final List<Widget> badges = [];

            for (int i = 0; i < _toolBadges.length * 2; i++) {
              final _ToolBadgeData data = _toolBadges[i % _toolBadges.length];
              final double x =
                  ((i * spacing) + travel) % (totalTrack * 2) - badgeSize - 26;

              if (x < -badgeSize || x > waveWidth + badgeSize) {
                continue;
              }

              final double t = waveWidth == 0
                  ? 0
                  : (x / waveWidth).clamp(0.0, 1.0);
              final double arch = math.sin(t * math.pi) * arcLift;
              final double floatY =
                  math.sin((progress * math.pi * 2) + i * 0.42) *
                  (compact ? 4 : 6);
              final double y = baseY - arch + floatY;
              final double tilt =
                  data.tilt +
                  math.sin((progress * math.pi * 2) + i * 0.16) * 0.04;

              badges.add(
                Positioned(
                  left: x,
                  top: y,
                  child: Transform.rotate(
                    angle: tilt,
                    child: _ToolBadgeCard(data: data, size: badgeSize),
                  ),
                ),
              );
            }

            return ClipRect(
              child: Stack(clipBehavior: Clip.none, children: badges),
            );
          },
        );
      },
    );
  }
}

class _ToolBadgeCard extends StatelessWidget {
  final _ToolBadgeData data;
  final double size;

  const _ToolBadgeCard({required this.data, required this.size});

  @override
  Widget build(BuildContext context) {
    final bool showWordmark = size >= 64;

    return Tooltip(
      message: data.label,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: data.gradient,
          color: data.gradient == null ? data.background : null,
          borderRadius: BorderRadius.circular(size * 0.26),
          border: Border.all(color: data.borderColor),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 22,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                data.icon,
                size: showWordmark ? size * 0.28 : size * 0.40,
                color: data.foreground,
              ),
              if (showWordmark) ...[
                SizedBox(height: size * 0.04),
                Text(
                  data.mark,
                  style: TextStyle(
                    color: data.foreground,
                    fontSize: size * 0.14,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneShowcase extends StatelessWidget {
  final AnimationController controller;
  final double width;
  final bool compact;

  const _PhoneShowcase({
    required this.controller,
    required this.width,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final double phoneHeight = width * 1.72;
    final List<_ToolBadgeData> orbitBadges = [
      _toolBadges[0],
      _toolBadges[8],
      _toolBadges[15],
      _toolBadges[20],
      _toolBadges[24],
    ];

    return SizedBox(
      width: width + (compact ? 30 : 110),
      height: phoneHeight + 40,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final double progress = controller.value * math.pi * 2;
          final double phoneLift = math.sin(progress) * 8;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < orbitBadges.length; i++)
                _FloatingOrbitBadge(
                  data: orbitBadges[i],
                  progress: progress,
                  index: i,
                  compact: compact,
                ),
              Positioned(
                left: compact ? 16 : 42,
                bottom: 8,
                child: Transform.translate(
                  offset: Offset(0, phoneLift),
                  child: Container(
                    width: width,
                    height: phoneHeight,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121212),
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: AppColors.orange.withValues(alpha: 0.88),
                        width: 2.4,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x55000000),
                          blurRadius: 30,
                          offset: Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 62,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: _PhoneChatPane(compact: compact),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          flex: 38,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF161616),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Column(
                              children: [
                                const _PhoneActionRow(),
                                const Spacer(),
                                _AnimatedWaveform(controller: controller),
                                const Spacer(),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.language,
                                    color: AppColors.orange,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PhoneChatPane extends StatelessWidget {
  final bool compact;

  const _PhoneChatPane({required this.compact});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool dense = compact || constraints.maxHeight < 330;
        final bool ultraDense = constraints.maxHeight < 296;
        final double gap = ultraDense ? 7 : (dense ? 8 : 10);
        final double maxBubbleWidth =
            constraints.maxWidth * (dense ? 0.72 : 0.76);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PhoneProfileRow(dense: dense),
            SizedBox(height: dense ? 10 : 12),
            _ChatBubble(
              text: "Cool, extra cream.",
              isReply: false,
              small: true,
              dense: dense,
              maxWidth: maxBubbleWidth,
            ),
            SizedBox(height: gap),
            _ChatBubble(
              text: "Also, are you still waiting on feedback\nfor the org doc?",
              isReply: false,
              dense: dense,
              maxWidth: maxBubbleWidth,
            ),
            SizedBox(height: gap),
            _ChatBubble(
              text: "All good there, the doc\nis fine.",
              isReply: true,
              dense: dense,
              maxWidth: maxBubbleWidth,
            ),
            SizedBox(height: gap),
            _ChatBubble(
              text: "Actually, wait, do we have\nthe Q1 forecast?",
              isReply: false,
              dense: dense,
              maxWidth: maxBubbleWidth,
            ),
            const Spacer(),
            _MessageField(dense: dense),
          ],
        );
      },
    );
  }
}

class _FloatingOrbitBadge extends StatelessWidget {
  final _ToolBadgeData data;
  final double progress;
  final int index;
  final bool compact;

  const _FloatingOrbitBadge({
    required this.data,
    required this.progress,
    required this.index,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final List<Offset> anchors = compact
        ? const [
            Offset(0, 130),
            Offset(198, 72),
            Offset(208, 228),
            Offset(44, 258),
            Offset(154, 300),
          ]
        : const [
            Offset(0, 156),
            Offset(266, 72),
            Offset(288, 228),
            Offset(40, 292),
            Offset(230, 368),
          ];

    final double offsetX = math.cos(progress + (index * 0.95)) * 12;
    final double offsetY = math.sin(progress + (index * 1.1)) * 10;
    final double angle = math.sin(progress + index) * 0.08;

    return Positioned(
      left: anchors[index].dx + offsetX,
      top: anchors[index].dy + offsetY,
      child: Transform.rotate(
        angle: angle,
        child: _ToolBadgeCard(data: data, size: compact ? 42 : 50),
      ),
    );
  }
}

class _AnimatedWaveform extends StatelessWidget {
  final AnimationController controller;

  const _AnimatedWaveform({required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<double> bars = [18, 30, 48, 64, 38, 22, 44, 66, 34, 18];

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double progress = controller.value * math.pi * 2;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(bars.length, (index) {
            final double factor =
                0.62 + (math.sin(progress + (index * 0.55)).abs() * 0.72);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                width: 6,
                height: bars[index] * factor,
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _PhoneProfileRow extends StatelessWidget {
  final bool dense;

  const _PhoneProfileRow({required this.dense});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: dense ? 30 : 32,
          height: dense ? 30 : 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF1D1D1D), Color(0xFF365B4F)],
            ),
          ),
          child: Icon(
            Icons.person,
            color: AppColors.orange,
            size: dense ? 16 : 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          "Jordan",
          style: TextStyle(
            color: AppColors.orange,
            fontSize: dense ? 14 : 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isReply;
  final bool small;
  final bool dense;
  final double maxWidth;

  const _ChatBubble({
    required this.text,
    required this.isReply,
    required this.maxWidth,
    this.small = false,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isReply ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: EdgeInsets.symmetric(
          horizontal: small ? 12 : (dense ? 12 : 14),
          vertical: small ? 9 : (dense ? 8 : 10),
        ),
        decoration: BoxDecoration(
          color: isReply ? const Color(0xFF37352E) : const Color(0xFF292929),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.86),
            fontSize: dense ? 12 : (small ? 12 : 13.5),
            height: 1.16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _MessageField extends StatelessWidget {
  final bool dense;

  const _MessageField({required this.dense});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dense ? 36 : 38,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(18),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Text(
        "|",
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.35),
          fontSize: dense ? 16 : 18,
        ),
      ),
    );
  }
}

class _PhoneActionRow extends StatelessWidget {
  const _PhoneActionRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2E2E2E),
          ),
          child: const Icon(Icons.close, color: AppColors.orange, size: 18),
        ),
        const Spacer(),
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.orange,
          ),
          child: const Icon(Icons.check, color: Colors.black, size: 18),
        ),
      ],
    );
  }
}

class _PlatformData {
  final String label;
  final IconData icon;

  const _PlatformData({required this.label, required this.icon});
}

class _ToolBadgeData {
  final String label;
  final String mark;
  final Color background;
  final Color foreground;
  final Color borderColor;
  final double tilt;
  final IconData icon;
  final Gradient? gradient;

  const _ToolBadgeData({
    required this.label,
    required this.mark,
    required this.background,
    required this.foreground,
    required this.borderColor,
    required this.tilt,
    required this.icon,
    this.gradient,
  });
}

const List<_PlatformData> _platforms = [
  _PlatformData(label: "iPhone", icon: Icons.phone_iphone_rounded),
  _PlatformData(label: "Mac", icon: Icons.laptop_mac_rounded),
  _PlatformData(label: "Windows", icon: Icons.window_rounded),
  _PlatformData(label: "Android", icon: Icons.android_rounded),
];

const List<_ToolBadgeData> _toolBadges = [
  _ToolBadgeData(
    label: "Slack",
    mark: "slack",
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF4A154B),
    borderColor: Color(0x12000000),
    tilt: -0.22,
    icon: Icons.forum_rounded,
  ),
  _ToolBadgeData(
    label: "npm",
    mark: "npm",
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFFCB3837),
    borderColor: Color(0x12000000),
    tilt: -0.12,
    icon: Icons.terminal_rounded,
  ),
  _ToolBadgeData(
    label: "VS Code",
    mark: "code",
    background: Color(0xFF007ACC),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: -0.18,
    icon: Icons.code_rounded,
  ),
  _ToolBadgeData(
    label: "Windsurf",
    mark: "wind",
    background: Color(0xFF172B3A),
    foreground: Color(0xFF68F2FF),
    borderColor: Color(0x12FFFFFF),
    tilt: -0.10,
    icon: Icons.air_rounded,
  ),
  _ToolBadgeData(
    label: "Antigravity",
    mark: "anti",
    background: Color(0xFF101010),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x28FFFFFF),
    tilt: -0.08,
    icon: Icons.rocket_launch_rounded,
  ),
  _ToolBadgeData(
    label: "Codex",
    mark: "codex",
    background: Color(0xFFE9F9F0),
    foreground: Color(0xFF0A6E43),
    borderColor: Color(0x14000000),
    tilt: 0.02,
    icon: Icons.auto_awesome_rounded,
  ),
  _ToolBadgeData(
    label: "Fire Studio",
    mark: "fire",
    background: Color(0xFFFF7A1A),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: 0.10,
    icon: Icons.local_fire_department_rounded,
  ),
  _ToolBadgeData(
    label: "Cursor",
    mark: "cursor",
    background: Color(0xFF0D0D0D),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x28FFFFFF),
    tilt: 0.16,
    icon: Icons.ads_click_rounded,
  ),
  _ToolBadgeData(
    label: "Jira",
    mark: "jira",
    background: Color(0xFF0C66E4),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: 0.20,
    icon: Icons.view_kanban_rounded,
  ),
  _ToolBadgeData(
    label: "Google Meet",
    mark: "meet",
    background: Color(0xFF34A853),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: 0.22,
    icon: Icons.videocam_rounded,
  ),
  _ToolBadgeData(
    label: "Skype",
    mark: "skype",
    background: Color(0xFF00AFF0),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: 0.18,
    icon: Icons.call_rounded,
  ),
  _ToolBadgeData(
    label: "Microsoft",
    mark: "ms",
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF2F2F2F),
    borderColor: Color(0x14000000),
    tilt: 0.12,
    icon: Icons.window_rounded,
  ),
  _ToolBadgeData(
    label: "Apple",
    mark: "apple",
    background: Color(0xFF111111),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x28FFFFFF),
    tilt: 0.05,
    icon: Icons.laptop_mac_rounded,
  ),
  _ToolBadgeData(
    label: "Android",
    mark: "android",
    background: Color(0xFF3DDC84),
    foreground: Color(0xFF111111),
    borderColor: Color(0x14000000),
    tilt: 0.02,
    icon: Icons.android_rounded,
  ),
  _ToolBadgeData(
    label: "iOS",
    mark: "ios",
    background: Color(0xFFEDEDED),
    foreground: Color(0xFF111111),
    borderColor: Color(0x14000000),
    tilt: -0.02,
    icon: Icons.phone_iphone_rounded,
  ),
  _ToolBadgeData(
    label: "AI Cloud",
    mark: "cloud",
    background: Color(0xFF171F3C),
    foreground: Color(0xFFA6C4FF),
    borderColor: Color(0x14FFFFFF),
    tilt: -0.08,
    icon: Icons.cloud_rounded,
  ),
  _ToolBadgeData(
    label: "Gemini",
    mark: "gem",
    background: Color(0xFF6449FF),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: -0.14,
    icon: Icons.blur_on_rounded,
  ),
  _ToolBadgeData(
    label: "Kimi",
    mark: "kimi",
    background: Color(0xFF0B4B5A),
    foreground: Color(0xFFDBFBFF),
    borderColor: Color(0x14FFFFFF),
    tilt: -0.20,
    icon: Icons.nights_stay_rounded,
  ),
  _ToolBadgeData(
    label: "Mobile iOS",
    mark: "mobile",
    background: Color(0xFF151515),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x28FFFFFF),
    tilt: -0.18,
    icon: Icons.phone_iphone_rounded,
  ),
  _ToolBadgeData(
    label: "Mobile Android",
    mark: "mobile",
    background: Color(0xFF93D500),
    foreground: Color(0xFF141414),
    borderColor: Color(0x14000000),
    tilt: -0.10,
    icon: Icons.phone_android_rounded,
  ),
  _ToolBadgeData(
    label: "Notion",
    mark: "notion",
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF111111),
    borderColor: Color(0x14000000),
    tilt: 0.04,
    icon: Icons.menu_book_rounded,
  ),
  _ToolBadgeData(
    label: "Microsoft Message",
    mark: "msg",
    background: Color(0xFF0078D4),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: 0.08,
    icon: Icons.message_rounded,
  ),
  _ToolBadgeData(
    label: "Perplexity",
    mark: "px",
    background: Color(0xFF0E2027),
    foreground: Color(0xFF9EF0FF),
    borderColor: Color(0x14FFFFFF),
    tilt: 0.12,
    icon: Icons.psychology_alt_rounded,
  ),
  _ToolBadgeData(
    label: "ChatGPT",
    mark: "gpt",
    background: Color(0xFF0F3D35),
    foreground: Color(0xFFD7FFF5),
    borderColor: Color(0x14FFFFFF),
    tilt: 0.18,
    icon: Icons.smart_toy_rounded,
  ),
  _ToolBadgeData(
    label: "VN",
    mark: "vn",
    background: Color(0xFF111111),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x28FFFFFF),
    tilt: 0.22,
    icon: Icons.movie_creation_outlined,
  ),
  _ToolBadgeData(
    label: "Picsart",
    mark: "art",
    background: Color(0xFFFF4ACB),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: 0.18,
    icon: Icons.brush_rounded,
  ),
  _ToolBadgeData(
    label: "Keka",
    mark: "zip",
    background: Color(0xFF5E3BFF),
    foreground: Color(0xFFFFFFFF),
    borderColor: Color(0x14000000),
    tilt: 0.12,
    icon: Icons.archive_rounded,
  ),
];

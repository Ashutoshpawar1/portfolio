import 'dart:async';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class LiveTimeWidget extends StatefulWidget {
  final bool isCompact;

  const LiveTimeWidget({super.key, required this.isCompact});

  @override
  State<LiveTimeWidget> createState() => _LiveTimeWidgetState();
}

class _LiveTimeWidgetState extends State<LiveTimeWidget> {
  Timer? _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _updateTime();
        });
      }
    });
  }

  void _updateTime() {
    // Calculate Ashutosh's local time (India - GMT+5:30)
    _currentTime = DateTime.now().toUtc().add(
      const Duration(hours: 5, minutes: 30),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    final int hour = dt.hour;
    final int minute = dt.minute;
    final int second = dt.second;
    final String amPm = hour >= 12 ? 'PM' : 'AM';
    final int hour12 = hour % 12 == 0 ? 12 : hour % 12;

    final String hrStr = hour12.toString().padLeft(2, '0');
    final String minStr = minute.toString().padLeft(2, '0');
    final String secStr = second.toString().padLeft(2, '0');

    return '$hrStr:$minStr:$secStr $amPm';
  }

  @override
  Widget build(BuildContext context) {
    final String timeStr = _formatTime(_currentTime);

    if (widget.isCompact) {
      return Wrap(
        spacing: 14,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _buildMetaBlock("LOCAL TIME", timeStr),
          _buildMetaBlock("ZONE", "IST (GMT+5:30)"),
          _buildMetaBlock("COUNTRY", "INDIA 🇮🇳"),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMetaBlock("LOCAL TIME", timeStr),
        const SizedBox(width: 28),
        _buildMetaBlock("ZONE", "IST (GMT+5:30)"),
        const SizedBox(width: 28),
        _buildMetaBlock("COUNTRY", "INDIA 🇮🇳"),
      ],
    );
  }

  Widget _buildMetaBlock(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

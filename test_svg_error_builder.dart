import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

Widget testSvg() {
  return SvgPicture.network(
    'test',
    errorBuilder: (context, error, stackTrace) => Container(),
  );
}

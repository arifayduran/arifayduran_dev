import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';

class SvgColorMapper implements ColorMapper {
  final Color fromColor;
  final Color toColor;
  final Color fromSecondColor;
  final Color toSecondColor;
  SvgColorMapper(
      {required this.fromColor,
      required this.toColor,
      required this.fromSecondColor,
      required this.toSecondColor});

  @override
  Color substitute(
      String? id, String elementName, String attributeName, Color color) {
    if (color == fromColor) {
      return toColor;
    } else if (color == fromSecondColor) {
      return toSecondColor;
    }
    return color;
  }
}

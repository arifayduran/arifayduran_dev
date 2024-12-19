import 'dart:async';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({
    super.key,
    required this.text,
    required this.initColor,
    required this.hoverColor,
    required this.minSize,
    required this.midSize,
    required this.maxSize,
    required this.fontWeight,
    this.textStyle,
    this.fontFamily,
    this.enableFirstAnimation = false,
    this.specialIndexes = const [],
    this.scaleFactors = const {},
    this.elevatedIndexes = const [],
  });

  final String text;
  final Color initColor;
  final Color hoverColor;
  final double minSize;
  final double midSize;
  final double maxSize;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final String? fontFamily;
  final bool enableFirstAnimation;
  final List<int> specialIndexes;
  final Map<int, double> scaleFactors;
  final List<int> elevatedIndexes;

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  int? selectedIndex;
  int? right;
  int? left;
  final List<GlobalKey> _textKeys = [];
  Timer? _initialAnimationTimer;
  int _visibleCharacters = 0;

  @override
  void initState() {
    super.initState();

    _textKeys.addAll(List.generate(widget.text.length, (_) => GlobalKey()));

    if (widget.enableFirstAnimation) {
      _runInitialAnimation();
      isFirstLaunchAnimationsDone = true;
    }
  }

  void _runInitialAnimation() {
    int currentIndex = 0;

    _initialAnimationTimer =
        Timer.periodic(const Duration(milliseconds: 150), (timer) {
      if (currentIndex >= widget.text.length) {
        timer.cancel();
        setState(() {
          selectedIndex = null;
          left = null;
          right = null;
          _visibleCharacters = widget.text.length;
        });
        return;
      }
      setState(() {
        _visibleCharacters = currentIndex + 1;
        selectedIndex = currentIndex;
        left = currentIndex - 1;
        right = currentIndex + 1;
      });
      currentIndex++;
    });
  }

  void _updateSelectedIndexFromPosition(Offset position) {
    for (int i = 0; i < _textKeys.length; i++) {
      final key = _textKeys[i];
      final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;
      final boxPosition = renderBox.localToGlobal(Offset.zero);
      final boxSize = renderBox.size;

      if (position.dx >= boxPosition.dx &&
          position.dx <= boxPosition.dx + boxSize.width) {
        setState(() {
          selectedIndex = i;
          left = i - 1;
          right = i + 1;
        });
        break;
      }
    }
  }

  double _getFontSize(int index) {
    if (selectedIndex == index) {
      return widget.maxSize;
    }

    if (left == index || right == index) {
      return widget.midSize;
    }

    if (widget.scaleFactors.containsKey(index)) {
      double scale = widget.scaleFactors[index]!;
      double scaledSize = widget.minSize * scale;
      if (widget.elevatedIndexes.contains(index)) {
        scaledSize = scaledSize * 1.5;
      }
      return scaledSize;
    } else if (widget.elevatedIndexes.contains(index)) {
      return widget.maxSize * 1.5;
    } else {
      return widget.minSize;
    }
  }

  Color _getTextColor(int index) {
    if (widget.specialIndexes.contains(index)) {
      return widget.hoverColor;
    } else if (selectedIndex == index) {
      return widget.hoverColor;
    } else if (left == index || right == index) {
      return widget.hoverColor.withValues(alpha: 0.8);
    } else {
      return widget.initColor;
    }
  }

  TextStyle _getTextStyle(int index, double size) {
    return TextStyle(
      color: _getTextColor(index),
      fontWeight: widget.fontWeight,
      fontSize: size,
      fontFamily: widget.fontFamily,
    ).merge(widget.textStyle);
  }

  double _calculateTotalTextWidth(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width;
  }

  @override
  void dispose() {
    _initialAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.text.split('');
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _updateSelectedIndexFromPosition(details.globalPosition);
      },
      child: ScreenUtilInit(
        builder: (context, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;

              double totalTextWidth = _calculateTotalTextWidth(
                widget.text,
                TextStyle(fontSize: widget.maxSize),
              );

              double scaleFactor =
                  totalTextWidth > maxWidth ? maxWidth / totalTextWidth : 1.0;

              Widget child(int index) {
                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      selectedIndex = index;
                      left = index - 1;
                      right = index + 1;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      selectedIndex = null;
                      left = null;
                      right = null;
                    });
                  },
                  child: TweenAnimationBuilder(
                    key: _textKeys[index],
                    tween: Tween<double>(
                      begin: widget.minSize * scaleFactor,
                      end: _getFontSize(index) * scaleFactor,
                    ),
                    duration: const Duration(milliseconds: 150),
                    builder: (context, size, child) {
                      return Transform.translate(
                        offset: widget.elevatedIndexes.contains(index)
                            ? Offset(0, -7)
                            : Offset.zero,
                        child: Text(
                          data[index],
                          style: _getTextStyle(index, size),
                        ),
                      );
                    },
                  ),
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(data.length, (index) {
                  return widget.enableFirstAnimation
                      ? index < _visibleCharacters
                          ? child(index)
                          : const SizedBox()
                      : child(index);
                }),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedTextBody extends StatefulWidget {
  const AnimatedTextBody(
      {super.key,
      required this.text,
      required this.initColor,
      required this.hoverColor,
      required this.minSize,
      required this.midSize,
      required this.maxSize,
      required this.fontWeight});

  final String text;
  final Color initColor;
  final Color hoverColor;
  final double minSize;
  final double midSize;
  final double maxSize;
  final FontWeight fontWeight;

  @override
  State<AnimatedTextBody> createState() => _AnimatedTextBodyState();
}

class _AnimatedTextBodyState extends State<AnimatedTextBody> {
  int? selectedIndex;
  int? right;
  int? left;

  final List<GlobalKey> _textKeys = [];

  @override
  void initState() {
    super.initState();
    _textKeys.addAll(List.generate(widget.text.length, (_) => GlobalKey()));
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
    } else if (left == index || right == index) {
      return widget.midSize;
    } else {
      return widget.minSize;
    }
  }

  Color _getTextColor(int index) {
    if (selectedIndex == index) {
      return widget.hoverColor;
    } else if (left == index || right == index) {
      return widget.hoverColor.withOpacity(0.8);
    } else {
      return widget.initColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.text.split('');
    return GestureDetector(onHorizontalDragUpdate: (details) {
      _updateSelectedIndexFromPosition(details.globalPosition);
    }, child: ScreenUtilInit(builder: (context, _) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(data.length, (index) {
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
                begin: widget.minSize,
                end: _getFontSize(index),
              ),
              duration: const Duration(milliseconds: 100),
              builder: (context, size, child) {
                return Text(
                  data[index],
                  style: TextStyle(
                    color: _getTextColor(index),
                    fontWeight: widget.fontWeight,
                    fontSize: size,
                  ),
                );
              },
            ),
          );
        }),
      );
    }));
  }
}

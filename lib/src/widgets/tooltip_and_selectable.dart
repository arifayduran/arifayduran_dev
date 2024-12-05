import 'package:flutter/material.dart';

class TooltipAndSelectable extends StatelessWidget {
  final String message;
  final Widget child;
  final int? durationMilliseconds;
  final bool? isSelectable;
  final bool? isTooltip;

  const TooltipAndSelectable({
    super.key,
    required this.message,
    required this.child,
    this.durationMilliseconds = 500,
    this.isSelectable = true,
    this.isTooltip = true,
  });

  @override
  Widget build(BuildContext context) {
    return isTooltip!
        ? Tooltip(
            message: message,
            waitDuration: Duration(milliseconds: durationMilliseconds!),
            child: isSelectable!
                ? SelectionArea(
                    child: child,
                  )
                : child,
          )
        : isSelectable!
            ? SelectionArea(
                child: child,
              )
            : child;
  }
}

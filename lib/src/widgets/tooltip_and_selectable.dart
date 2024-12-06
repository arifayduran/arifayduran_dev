import 'package:flutter/material.dart';

class TooltipAndSelectable extends StatelessWidget {
  final String message;
  final int durationMilliseconds;
  final bool isSelectable;
  final bool isTooltip;
  final Widget child;

  const TooltipAndSelectable({
    super.key,
    this.message = "",
    this.durationMilliseconds = 500,
    this.isSelectable = true,
    this.isTooltip = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return isTooltip
        ? Tooltip(
            message: message,
            waitDuration: Duration(milliseconds: durationMilliseconds),
            child: isSelectable
                ? SelectionArea(
                    child: child,
                  )
                : child,
          )
        : isSelectable
            ? SelectionArea(
                child: child,
              )
            : child;
  }
}

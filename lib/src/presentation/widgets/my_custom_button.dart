import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color textSecondaryColor;
  final Color backgroundColor;
  final Color backgroundSecondaryColor;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const MyCustomButton({
    super.key,
    required this.text,
    this.textColor = Colors.black,
    this.textSecondaryColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.backgroundSecondaryColor = Colors.transparent,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all<Color>(textColor),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return BorderSide(color: textSecondaryColor, width: 2);
          }

          return BorderSide(color: textColor, width: 2);
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return backgroundSecondaryColor;
          }

          return backgroundColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.focused) ||
              states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return textSecondaryColor;
          }

          return textColor;
        }),
        textStyle: WidgetStatePropertyAll(GoogleFonts.montserrat(
          textStyle: const TextStyle(fontSize: 14, letterSpacing: 1),
        )),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(padding),
      ),
      child: Text(
        text,
      ),
    );
  }
}

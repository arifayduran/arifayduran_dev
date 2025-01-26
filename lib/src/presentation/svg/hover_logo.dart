import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/presentation/svg/svg_color_mapper.dart';
import 'package:arifayduran_dev/src/presentation/svg/svg_shadow_painter_oval.dart';
import 'package:arifayduran_dev/src/presentation/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HoverLogo extends StatefulWidget {
  const HoverLogo({super.key, required this.isDark});

  final bool isDark;

  @override
  State<HoverLogo> createState() => _HoverLogoState();
}

class _HoverLogoState extends State<HoverLogo> {
  bool isHovered = false;

  double _widthFactor = 1.0;
  double _heightFactor = 1.0;

  void _activateHover() {
    setState(() {
      isHovered = true;
      _widthFactor = 1.1;
      _heightFactor = 1.1;
    });
  }

  void _deactivateHover() {
    setState(() {
      _widthFactor = 1.0;
      _heightFactor = 1.0;
      Future.delayed(Duration(milliseconds: 300), () {
        isHovered = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final toolbarHeight = Provider.of<ToolbarProvider>(context).toolbarHeight;
    logoSpace = toolbarHeight * 1.8 * 1.3454258675 * _widthFactor;

    return MouseRegion(
      onEnter: (_) {
        _activateHover();
      },
      onExit: (_) {
        _deactivateHover();
      },
      child: GestureDetector(
        onTapDown: (_) {
          _activateHover();
        },
        onTapCancel: () {
          _deactivateHover();
        },
        onTap: () {
          Navigator.pushNamed(context, "/");
        },
        child: TooltipAndSelectable(
          isSelectable: false,
          isTooltip: true,
          message: AppLocalizations.of(context)!.logoOnHover,
          child: AnimatedContainer(
            duration: Duration(
                milliseconds: logoAnimate
                    ? toolbarAnimationDuration
                    : isHovered
                        ? 300
                        : 0),
            curve: Curves.easeInOut,
            width: toolbarHeight * 1.8 * 1.3454258675 * _widthFactor,
            height: toolbarHeight * 1.8 * _heightFactor,
            child: CustomPaint(
              painter: SvgShadowPainterOval(
                shadowColor:
                    widget.isDark ? touchColorDark : secondaryTouchColorLight,
                shouldReverse: false,
              ),
              child: SvgPicture(
                SvgAssetLoader(
                  "assets/app_icons/logo_graphic_red_top_new.svg",
                  // "assets/app_icons/logo_graphic_red_top_new_quadro.svg",
                  colorMapper: SvgColorMapper(
                    fromColor: const Color(0xFFD02A1E),
                    toColor: widget.isDark ? touchColorDark : touchColorLight,
                    fromSecondColor: const Color(0xFFFFFFFF),
                    toSecondColor: widget.isDark
                        ? secondaryTouchColorDark
                        : secondaryTouchColorLight,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

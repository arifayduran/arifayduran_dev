import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/language_selector.dart';
import 'package:arifayduran_dev/src/presentation/svg_color_mapper.dart';
import 'package:arifayduran_dev/src/presentation/widgets/animated_scroll_text.dart';
import 'package:arifayduran_dev/src/presentation/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/ui_mode_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ToolbarProvider extends ChangeNotifier {
  Color scrolledPlaceColor = effectColorDark;
  double toolbarHeight = maxToolbarHeight;
  Duration duration = const Duration(milliseconds: 1000);

  void updateToolBar(Color color, double height, Duration newDuration) {
    duration = newDuration;
    scrolledPlaceColor = color;
    toolbarHeight = height;

    notifyListeners();
  }
}

class MyToolbar extends StatefulWidget {
  const MyToolbar({super.key, required this.uiModeController});

  final UiModeController uiModeController;

  @override
  State<MyToolbar> createState() => _MyToolbarProvider();
}

class _MyToolbarProvider extends State<MyToolbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  double _currentHeight = 70.0;

  @override
  void initState() {
    super.initState();
    widget.uiModeController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    final toolbarProvider =
        Provider.of<ToolbarProvider>(context, listen: false);

    _controller = AnimationController(
      vsync: this,
      duration: toolbarProvider.duration,
    );

    _heightAnimation = Tween<double>(
      begin: _currentHeight,
      end: toolbarProvider.toolbarHeight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    toolbarProvider.addListener(() {
      _animateToolbarHeight(toolbarProvider.toolbarHeight);
    });
  }

  void _animateToolbarHeight(double newHeight) {
    if (!mounted) return;
    setState(() {
      _heightAnimation = Tween<double>(
        begin: _currentHeight,
        end: newHeight,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));

      _currentHeight = newHeight;
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToolbarProvider toolbarProvider = Provider.of<ToolbarProvider>(context);

    return AnimatedContainer(
      duration: toolbarProvider.duration,
      curve: Curves.easeInOut,
      height: toolbarProvider.toolbarHeight,
      color: toolbarProvider.scrolledPlaceColor,
      child: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: _heightAnimation.value,
        leadingWidth: toolbarProvider.toolbarHeight * 2,
        leading: SizedBox(
            height: toolbarProvider.toolbarHeight,
            child: widget.uiModeController.darkModeSet
                ? SvgPicture(SvgAssetLoader(
                    "assets/app_icons/logo_graphic_top_SVG.svg",
                    colorMapper: SvgColorMapper(
                        fromColor: const Color(0xFFD02A1E),
                        toColor: mainRed,
                        fromSecondColor: white,
                        toSecondColor: white)))
                : SvgPicture(SvgAssetLoader(
                    "assets/app_icons/logo_graphic_top_SVG.svg",
                    colorMapper: SvgColorMapper(
                        fromColor: const Color(0xFFD02A1E),
                        toColor: lightBlue,
                        fromSecondColor: white,
                        toSecondColor: black)))),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Center(
                  child: TooltipAndSelectable(
                    isTooltip: true,
                    isSelectable: false,
                    message: AppLocalizations.of(context)!.appDescription,
                    child: AnimatedTextBody(
                      text: AppLocalizations.of(context)!.appTitle,
                      initColor: white,
                      hoverColor: mainRed,
                      minSize: 20,
                      midSize: 25,
                      maxSize: 35,
                      // minSize: 40,
                      // midSize: 45,
                      // maxSize: 55,
                      fontWeight: FontWeight.normal,
                      textStyle: GoogleFonts.beauRivage(letterSpacing: 1.5),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TooltipAndSelectable(
                    isTooltip: true,
                    isSelectable: false,
                    message: widget.uiModeController.darkModeSet
                        ? AppLocalizations.of(context)!.toggleHoverToLight
                        : AppLocalizations.of(context)!.toggleHoverToDark,
                    child: UiModeSwitch(
                      uiModeController: widget.uiModeController,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  LanguageSelector(
                    uiModeController: widget.uiModeController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

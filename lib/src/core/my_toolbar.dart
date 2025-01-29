import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/language_selector.dart';
import 'package:arifayduran_dev/src/presentation/svg/svg_shadow_painter_oval.dart';
import 'package:arifayduran_dev/src/presentation/widgets/animated_text_widget.dart';
import 'package:arifayduran_dev/src/presentation/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/ui_mode_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

// class ToolbarProvider extends ChangeNotifier {
//   late double providersmaxBarsHeight; // didnt use for now
//   late double providersminBarsHeight; // didnt use for now
//   late double toolbarHeight;
//   Duration duration;
//   Color scrolledPlaceColor;

//   ToolbarProvider({
//     this.duration = const Duration(milliseconds: toolbarAnimationDuration),
//   }) {
//     providersmaxBarsHeight = maxBarsHeight;
//     providersminBarsHeight = minBarsHeight;
//     toolbarHeight = providersmaxBarsHeight;
//   }

//   void updateToolbar(Color color, double height, Duration newDuration) {
//     duration = newDuration;
//     scrolledPlaceColor = color;
//     toolbarHeight = height;
//     notifyListeners();
//   }

// }

class ToolbarProvider extends ChangeNotifier {
  // double? providersmaxBarsHeight = maxBarsHeight; // didnt used for now
  // double? providersminBarsHeight = minBarsHeight; // didnt used for now

  Color scrolledPlaceColor = effectColorDark;
  double toolbarHeight = maxBarsHeight;
  Duration duration = Duration(milliseconds: routeDurationMs);

  void updateToolbar(Color color, double height, Duration newDuration) {
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
  State<MyToolbar> createState() => _MyToolbarState();
}

class _MyToolbarState extends State<MyToolbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late double _currentHeight;
  late ToolbarProvider _toolbarProvider;
  late Color _toolbarColor;
  late Duration _toolbarAnimationDuration;

  @override
  void initState() {
    super.initState();

    widget.uiModeController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _toolbarProvider = Provider.of<ToolbarProvider>(context, listen: false);
    _currentHeight = _toolbarProvider.toolbarHeight;

    _controller = AnimationController(
      vsync: this,
      duration: _toolbarProvider.duration,
    );

    _heightAnimation = Tween<double>(
      begin: _currentHeight,
      end: _toolbarProvider.toolbarHeight,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _toolbarColor = _toolbarProvider.scrolledPlaceColor;
    _toolbarAnimationDuration = Duration(microseconds: 0);

    _toolbarProvider.addListener(() {
      _toolbarAnimationDuration = _toolbarProvider.duration;
      _animateToolbarHeight(_toolbarProvider.toolbarHeight);
      _toolbarColor = _toolbarProvider.scrolledPlaceColor;
    });
  }

  void _animateToolbarHeight(double newHeight) {
    if (!mounted) return;

    if (newHeight != _currentHeight) {
      _heightAnimation = Tween<double>(
        begin: _currentHeight,
        end: newHeight,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));

      _currentHeight = newHeight;

      _controller.reset();
      _controller.forward();
    }
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {});
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _heightAnimation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: _toolbarAnimationDuration,
            curve: Curves.easeInOut,
            height: _heightAnimation.value,
            color: _toolbarColor,
            child: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: _heightAnimation.value,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: logoSpace,
                  ),
                  Expanded(
                    // flex: 5,
                    child: !ResponsiveBreakpoints.of(context)
                            .smallerThan(MOBILE)
                        ? TooltipAndSelectable(
                            isTooltip: true,
                            isSelectable: false,
                            message:
                                "${AppLocalizations.of(context)!.appTitle} - ${AppLocalizations.of(context)!.appDescription}",
                            child: AnimatedTextWidget(
                              text:
                                  "ArifAyduran.dev", // AppLocalizations.of(context)!.appTitle,
                              hoverColor: widget.uiModeController.darkModeSet
                                  ? secondaryTouchColorDark
                                  : secondaryTouchColorLight,
                              initColor: widget.uiModeController.darkModeSet
                                  ? touchColorDark
                                  : touchColorLight,
                              minSize: !ResponsiveBreakpoints.of(context)
                                      .smallerThan("Big")
                                  ? 45
                                  : 30,
                              midSize: !ResponsiveBreakpoints.of(context)
                                      .smallerThan("Big")
                                  ? 55
                                  : 35,
                              maxSize: !ResponsiveBreakpoints.of(context)
                                      .smallerThan("Big")
                                  ? 70
                                  : 40,
                              fontWeight: FontWeight.w400,
                              textStyle:
                                  GoogleFonts.beauRivage(letterSpacing: 2),
                              enableFirstAnimation:
                                  isFirstLaunchAnimationsDone ? false : true,

                              specialIndexes: [0, 4, 11, 12, 13, 14],
                              elevatedIndexes: [11, 12, 13, 14],
                              scaleFactors: {
                                11: 0.5,
                                12: 0.5,
                                13: 0.5,
                                14: 0.5
                              },
                            ),
                          )
                        : SizedBox(),
                  ),
                  if (!ResponsiveBreakpoints.of(context).smallerThan("Big"))
                    CustomPaint(
                      painter: SvgShadowPainterOval(
                          shadowColor: widget.uiModeController.darkModeSet
                              ? touchColorDark
                              : secondaryTouchColorLight,
                          blur: 60,
                          topOffset: 0,
                          alpha: 0.7,
                          shouldReverse: false),
                      child: Row(
                        children: [
                          TooltipAndSelectable(
                            isTooltip: true,
                            isSelectable: false,
                            message: widget.uiModeController.darkModeSet
                                ? AppLocalizations.of(context)!
                                    .toggleHoverToLight
                                : AppLocalizations.of(context)!
                                    .toggleHoverToDark,
                            child: UiModeSwitch(
                              uiModeController: widget.uiModeController,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          LanguageSelector(
                            uiModeController: widget.uiModeController,
                          ),
                        ],
                      ),
                    ),
                  if (ResponsiveBreakpoints.of(context).smallerThan("Big"))
                    CustomPaint(
                      painter: SvgShadowPainterOval(
                          shadowColor: widget.uiModeController.darkModeSet
                              ? touchColorDark
                              : secondaryTouchColorLight,
                          blur: 35,
                          topOffset: 0,
                          alpha: 1,
                          shouldReverse: false),
                      child: Tooltip(
                        message: AppLocalizations.of(context)!.drawerOnHover,
                        child: PopupMenuButton<Widget>(
                          icon: const Icon(Icons.menu_rounded),
                          itemBuilder: (context) => <PopupMenuEntry<Widget>>[
                            PopupMenuItem(
                              enabled: false,
                              child: Center(
                                child: LanguageSelector(
                                  uiModeController: widget.uiModeController,
                                ),
                              ),
                            ),
                            PopupMenuDivider(),
                            PopupMenuItem<Widget>(
                              enabled: false,
                              child: Center(
                                child: TooltipAndSelectable(
                                  isTooltip: true,
                                  isSelectable: false,
                                  message: widget.uiModeController.darkModeSet
                                      ? AppLocalizations.of(context)!
                                          .toggleHoverToLight
                                      : AppLocalizations.of(context)!
                                          .toggleHoverToDark,
                                  child: UiModeSwitch(
                                    uiModeController: widget.uiModeController,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}

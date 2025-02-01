import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/home/presentation/home_screen.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/deactivated/routes_service.dart'; // not using since observer
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageNotFoundScreen extends StatefulWidget {
  const PageNotFoundScreen(
      {super.key, required this.pathName, required this.uiModeController});

  final UiModeController uiModeController;
  static const routeName = '/404';
  final String pathName;

  static double lastToolbarHeightBeforePush = maxBarsHeight;
  static Color lastToolbarScrolledPlaceColorDark = effectColorDark;
  static Color lastToolbarScrolledPlaceColorLight = effectColorLight;

  @override
  State<PageNotFoundScreen> createState() => _PageNotFoundScreenState();
}

class _PageNotFoundScreenState extends State<PageNotFoundScreen> {
  late bool isBackOrGoHome;

  @override
  void initState() {
    super.initState();

    isBackOrGoHome = notNavigatedFromRefresh;

    widget.uiModeController.addListener(() {
      if (mounted) {
        setState(() {
          _updateToolbar(
              widget.uiModeController.darkModeSet
                  ? effectColorDark
                  : effectColorLight,
              maxBarsHeight,
              0);
          // _updateBottombar(
          //     widget.uiModeController.darkModeSet
          //         ? effectColorDark
          //         : effectColorLight,
          //     maxBarsHeight,
          //     0);
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadedScreens["PageNotFoundScreen"] = true;
    });
  }

  void _updateToolbar(Color color, double height, int ms) {
    Provider.of<ToolbarProvider>(context, listen: false)
        .updateToolbar(color, height, Duration(milliseconds: ms));
  }

  // void _updateBottombar(Color color, double height, int ms) {
  //   Provider.of<BottombarProvider>(context, listen: false)
  //       .updateBottombar(color, height, Duration(milliseconds: ms));
  // }

  void _onRoute() {
    // HomeScreen.lastToolbarHeightBeforePush = _getToolbarSize();
    // double opacity = (_scrollController.position.pixels /
    //         (MediaQuery.of(context).size.height - 50 - 200))
    //     .clamp(0.0, 1.0);

    // HomeScreen.lastToolbarScrolledPlaceColorDark =
    //     Color.lerp(_effectColorDark, _destinationColorDark, opacity)!;
    // HomeScreen.lastToolbarScrolledPlaceColorLight =
    //     Color.lerp(_effectColorLight, _destinationColorDark, opacity)!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (willPop, result) {
        logoAnimate = true;
        Future.delayed(Duration(milliseconds: routeDurationMs), () {
          logoAnimate = false;
        });

        _onRoute();
        _updateToolbar(
            widget.uiModeController.darkModeSet
                ? HomeScreen.lastToolbarScrolledPlaceColorDark
                : HomeScreen.lastToolbarScrolledPlaceColorLight,
            HomeScreen.lastToolbarHeightBeforePush,
            routeDurationMs);
        // _updateBottombar(
        //     widget.uiModeController.darkModeSet
        //         ? HomeScreen.lastToolbarScrolledPlaceColorDark
        //         : HomeScreen.lastToolbarScrolledPlaceColorLight,
        //     HomeScreen.lastToolbarHeightBeforePush,
        //     routeDurationMs);
        if (notNavigatedFromRefresh) {
          willPop = false;
          if (!Navigator.of(context).canPop()) {
            return;
          }
          Navigator.pop(context);
        } else {}
        notNavigatedFromRefresh = false;
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const AnimatedTextBody(
                //   text: "Testtextwasgeht",
                //   hoverColor: Colors.grey,
                //   initColor: Colors.white,
                //   maxSize: 50,
                //   midSize: 40,
                //   minSize: 30,
                //   fontWeight: FontWeight.w500,
                // ),
                // ),

                SizedBox(
                    height: 300,
                    width: 300,
                    child: Lottie.asset("assets/animations/404.json")),

                const SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    AppLocalizations.of(context)!
                        .pageNotFound(widget.pathName), // arifayduran.dev...
                    style: descriptionStyle?.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () {
                    if (notNavigatedFromRefresh) {
                      // RouteService().updateLastVisitedRoute('/'); // not using since observer

                      logoAnimate = true;
                      Future.delayed(Duration(milliseconds: routeDurationMs),
                          () {
                        logoAnimate = false;
                      });

                      _onRoute();
                      _updateToolbar(
                          widget.uiModeController.darkModeSet
                              ? HomeScreen.lastToolbarScrolledPlaceColorDark
                              : HomeScreen.lastToolbarScrolledPlaceColorLight,
                          HomeScreen.lastToolbarHeightBeforePush,
                          routeDurationMs);
                      // _updateBottombar(
                      //     widget.uiModeController.darkModeSet
                      //         ? HomeScreen.lastToolbarScrolledPlaceColorDark
                      //         : HomeScreen.lastToolbarScrolledPlaceColorLight,
                      //     HomeScreen.lastToolbarHeightBeforePush,
                      //     routeDurationMs);

                      if (!Navigator.of(context).canPop()) {
                        return;
                      }

                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        if (mounted && Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      });
                    } else {
                      logoAnimate = true;
                      Future.delayed(Duration(milliseconds: routeDurationMs),
                          () {
                        logoAnimate = false;
                      });

                      _onRoute();
                      _updateToolbar(
                          widget.uiModeController.darkModeSet
                              ? HomeScreen.lastToolbarScrolledPlaceColorDark
                              : HomeScreen.lastToolbarScrolledPlaceColorLight,
                          HomeScreen.lastToolbarHeightBeforePush,
                          routeDurationMs);
                      // _updateBottombar(
                      //     widget.uiModeController.darkModeSet
                      //         ? HomeScreen.lastToolbarScrolledPlaceColorDark
                      //         : HomeScreen.lastToolbarScrolledPlaceColorLight,
                      //     HomeScreen.lastToolbarHeightBeforePush,
                      //     routeDurationMs);

                      Navigator.pushNamed(context, "/");
                    }
                    notNavigatedFromRefresh = false;
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          widget.uiModeController.darkModeSet
                              ? mainRed
                              : white)),
                  child: Text(
                    isBackOrGoHome
                        ? AppLocalizations.of(context)!.back
                        : AppLocalizations.of(context)!.goToHome,
                    style: descriptionStyle?.copyWith(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

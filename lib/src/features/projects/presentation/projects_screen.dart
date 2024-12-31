import 'package:arifayduran_dev/src/config/route_links.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/application/url_launcher_new_tab.dart';
import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/home/presentation/home_screen.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/deactivated/routes_service.dart'; // not using since observer
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/presentation/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key, required this.uiModeController});

  final UiModeController uiModeController;
  static const routeName = '/projects';

  static double lastToolbarHeightBeforePush = maxBarsHeight;
  static Color lastToolbarScrolledPlaceColorDark = effectColorDark;
  static Color lastToolbarScrolledPlaceColorLight = effectColorLight;

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (willPop, result) {
        _onRoute();
        _updateToolbar(
            widget.uiModeController.darkModeSet
                ? HomeScreen.lastToolbarScrolledPlaceColorDark
                : HomeScreen.lastToolbarScrolledPlaceColorLight,
            HomeScreen.lastToolbarHeightBeforePush,
            toolbarAnimationDuration);
        // _updateBottombar(
        //     widget.uiModeController.darkModeSet
        //         ? HomeScreen.lastToolbarScrolledPlaceColorDark
        //         : HomeScreen.lastToolbarScrolledPlaceColorLight,
        //     HomeScreen.lastToolbarHeightBeforePush,
        //     toolbarAnimationDuration);
        if (notNavigatedFromRefresh) {
          willPop = false;
          if (!Navigator.of(context).canPop()) {
            return;
          }
          Navigator.pop(context, "/");
        } else {}
        notNavigatedFromRefresh = false;
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
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
              TooltipAndSelectable(
                isTooltip: true,
                isSelectable: false,
                message: "Link to $wetterAppUrl",
                child: TextButton(
                  onPressed: () {
                    urlLauncherNewTab(wetterAppUrl);
                  },
                  child: Text(
                    "Wetter App",
                    style: descriptionStyle?.copyWith(),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              TextButton(
                onPressed: () {
                  if (notNavigatedFromRefresh) {
                    // RouteService().updateLastVisitedRoute('/'); // not using since observer

                    _onRoute();
                    _updateToolbar(
                        widget.uiModeController.darkModeSet
                            ? HomeScreen.lastToolbarScrolledPlaceColorDark
                            : HomeScreen.lastToolbarScrolledPlaceColorLight,
                        HomeScreen.lastToolbarHeightBeforePush,
                        toolbarAnimationDuration);
                    // _updateBottombar(
                    //     widget.uiModeController.darkModeSet
                    //         ? HomeScreen.lastToolbarScrolledPlaceColorDark
                    //         : HomeScreen.lastToolbarScrolledPlaceColorLight,
                    //     HomeScreen.lastToolbarHeightBeforePush,
                    //     toolbarAnimationDuration);
                    if (!Navigator.of(context).canPop()) {
                      return;
                    }
                    Navigator.pop(context, "/");
                  } else {
                    _onRoute();
                    _updateToolbar(
                        widget.uiModeController.darkModeSet
                            ? HomeScreen.lastToolbarScrolledPlaceColorDark
                            : HomeScreen.lastToolbarScrolledPlaceColorLight,
                        HomeScreen.lastToolbarHeightBeforePush,
                        toolbarAnimationDuration);
                    // _updateBottombar(
                    //     widget.uiModeController.darkModeSet
                    //         ? HomeScreen.lastToolbarScrolledPlaceColorDark
                    //         : HomeScreen.lastToolbarScrolledPlaceColorLight,
                    //     HomeScreen.lastToolbarHeightBeforePush,
                    //     toolbarAnimationDuration);
                    Navigator.pushNamed(context, "/");
                  }
                  notNavigatedFromRefresh = false;
                },
                child: Text(
                  "Zurück",
                  style: descriptionStyle?.copyWith(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

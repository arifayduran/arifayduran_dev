import 'package:arifayduran_dev/src/config/route_links.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/application/url_launcher_new_tab.dart';
import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/home/presentation/home_screen.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/deactivated/routes_service.dart'; // not using since observer
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/widgets/animated_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key, required this.uiModeController});

  final UiModeController uiModeController;
  static const routeName = '/projects';

  static double lastToolbarHeightBeforePush = maxToolbarHeight;
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
          _updateToolBar(
              widget.uiModeController.darkModeSet
                  ? effectColorDark
                  : effectColorLight,
              maxToolbarHeight,
              0);
        });
      }
    });
  }

  void _updateToolBar(Color color, double height, int ms) {
    Provider.of<ToolbarProvider>(context, listen: false)
        .updateToolBar(color, height, Duration(milliseconds: ms));
  }

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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            Provider.of<ToolbarProvider>(context, listen: false).toolbarHeight),
        child: myToolbar,
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (notNavigatedFromRefresh) {
                    // RouteService().updateLastVisitedRoute('/'); // not using since observer
                    Navigator.pop(context, "/");
                    _onRoute();
                    _updateToolBar(
                        widget.uiModeController.darkModeSet
                            ? HomeScreen.lastToolbarScrolledPlaceColorDark
                            : HomeScreen.lastToolbarScrolledPlaceColorLight,
                        HomeScreen.lastToolbarHeightBeforePush,
                        1000);
                  } else {
                    Navigator.pushNamed(context, "/");
                    _onRoute();
                    _updateToolBar(
                        widget.uiModeController.darkModeSet
                            ? HomeScreen.lastToolbarScrolledPlaceColorDark
                            : HomeScreen.lastToolbarScrolledPlaceColorLight,
                        HomeScreen.lastToolbarHeightBeforePush,
                        1000);
                  }
                  notNavigatedFromRefresh = false;
                },
                child: Text(
                  "Zurück",
                  style: descriptionStyle?.copyWith(),
                ),
              ),
              TextButton(
                onPressed: () {
                  urlLauncherNewTab(wetterAppUrl);
                },
                child: Text(
                  "Wetter App",
                  style: descriptionStyle?.copyWith(),
                ),
              ),
              const AnimatedTextBody(
                text: "Testtextwasgeht",
                hoverColor: Colors.grey,
                initColor: Colors.white,
                maxSize: 50,
                midSize: 40,
                minSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

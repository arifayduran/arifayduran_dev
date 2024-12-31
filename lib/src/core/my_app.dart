import 'package:arifayduran_dev/src/core/application/scaffold_messenger_key.dart';
import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/projects/presentation/projects_screen.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/language_provider.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/deactivated/routes_service.dart'; // not using since observer
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/presentation/svg/hover_logo.dart';
// import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart'; // not using since observer
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/config/my_custom_scroll_behavior.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/home/presentation/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.uiModeController});

  final UiModeController uiModeController;
  // final RouteService _routeService = RouteService(); // not using since observer

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: uiModeController,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: child!,
              breakpoints: [
                const Breakpoint(start: 0, end: 300, name: "Small"),
                const Breakpoint(start: 301, end: 600, name: MOBILE),
                const Breakpoint(start: 601, end: double.infinity, name: "Big"),
                // const Breakpoint(start: 0, end: 450, name: MOBILE),
                // const Breakpoint(start: 451, end: 800, name: TABLET),
                // const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                // const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            scrollBehavior: MyCustomScrollBehavior(),
            scaffoldMessengerKey: scaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            locale: Provider.of<LanguageProvider>(context).currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: uiModeController.themeMode,
            initialRoute: initialRoute, // "/",
            navigatorObservers: [routeObserver],
            onGenerateInitialRoutes: (initialRoute) {
              final Uri uri = Uri.parse(initialRoute);
              return [
                buildPage(path: uri.path, queryParams: uri.queryParameters),
              ];
            },
            onGenerateRoute: (RouteSettings routeSettings) {
              final Uri uri = Uri.parse(routeSettings.name ?? '/');

              // return Routes.opacityTransition(
              //   settings: routeSettings,
              //   builder: (context) {
              // return buildPage(routeSettings.name ?? ''),
              //         dragWithMouse: true)); ---- ?????

              return buildPage(
                  path: uri.path, queryParams: uri.queryParameters);
              // },
              // );
              // onGenerateRoute: (RouteSettings routeSettings) {
              //   // currentRoute = routeSettings.name; // not using since observer

              //   // if (dontSaveFirstRoute) {
              //   //   _routeService.updateLastVisitedRoute(routeSettings.name ?? '/');
              //   // } // not using since observer

              //   //  dontSaveFirstRoute = true; // not using since observer
              // },
            },
          );
        });
  }

  Route<dynamic> buildPage(
      {required String path, Map<String, String> queryParams = const {}}) {
    return PageRouteBuilder(
        settings: RouteSettings(
            name: (path.startsWith('/') == false) ? '/$path' : path),
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          final toolbarProvider =
              Provider.of<ToolbarProvider>(context, listen: false);
          // final bottombarProvider =
          //     Provider.of<BottombarProvider>(context, listen: false);
          if (uiModeController.darkModeSet) {
            toolbarProvider.scrolledPlaceColor = effectColorDark;
            // bottombarProvider.scrolledPlaceColor = effectColorDark;
          } else {
            toolbarProvider.scrolledPlaceColor = effectColorLight;
            // bottombarProvider.scrolledPlaceColor = effectColorLight;
          }
          String pathName = path; // Kein `substring(1)`
          // String pathName =
          //     path != '/' && path.startsWith('/') ? path.substring(1) : path;

          return Scaffold(
            backgroundColor: toolbarProvider.scrolledPlaceColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  Provider.of<ToolbarProvider>(context).toolbarHeight),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  myToolbar,
                  Positioned(
                      top: 0,
                      left: 0,
                      child: HoverLogo(isDark: uiModeController.darkModeSet)),
                ],
              ),
            ),
            // extendBody: true,
            // bottomNavigationBar:
            //     MyBottombar(uiModeController: uiModeController),
            body:

                // Stack(
                //   clipBehavior: Clip.none,
                //   children: [
                FadeTransition(
                    opacity: animation,
                    child: switch (pathName) {
                      '/' ||
                      HomeScreen.routeName =>
                        HomeScreen(uiModeController: uiModeController),
                      ProjectsScreen.routeName =>
                        ProjectsScreen(uiModeController: uiModeController),
                      "/placeholder" =>

                        // const ResponsiveBreakpoints(breakpoints: [
                        //   Breakpoint(start: 0, end: 480, name: MOBILE),
                        //   Breakpoint(start: 481, end: 1200, name: TABLET),
                        //   Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
                        // ], child:
                        const Placeholder(),
                      // ),

                      String() =>
                        HomeScreen(uiModeController: uiModeController),
                    }),
            // Positioned.fill(
            //   left: -634,
            //   child: CustomPaint(
            //     painter: VerticalLinePainter(),
            //   ),
            // ),
            //   ],
            // ),
          );
        });
  }
}

// class VerticalLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = const Color.fromARGB(129, 255, 255, 255) // Farbe der Linie
//       ..strokeWidth = 1.0 // Breite der Linie
//       ..style = PaintingStyle.stroke;

//     // Zeichne eine Linie von oben nach unten in der Mitte des Bildschirms
//     final double startX = size.width / 2; // X-Position (zentriert)
//     canvas.drawLine(
//       Offset(startX, 0), // Startpunkt (oben)
//       Offset(startX, size.height), // Endpunkt (unten)
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

import 'package:arifayduran_dev/src/core/application/scaffold_messenger_key.dart';
import 'package:arifayduran_dev/src/features/projects/presentation/projects_screen.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/language_provider.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/deactivated/routes_service.dart'; // not using since observer
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
// import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart'; // not using since observer
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/config/my_custom_scroll_behavior.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/home/presentation/home_screen.dart';
import 'package:provider/provider.dart';

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
          onGenerateRoute: (RouteSettings routeSettings) {
            // currentRoute = routeSettings.name; // not using since observer

            // if (dontSaveFirstRoute) {
            //   _routeService.updateLastVisitedRoute(routeSettings.name ?? '/');
            // } // not using since observer

            //  dontSaveFirstRoute = true; // not using since observer

            return PageRouteBuilder<void>(
              settings: routeSettings,
              pageBuilder: (context, animation, secondaryAnimation) {
                switch (routeSettings.name) {
                  /////////
                  case ProjectsScreen.routeName:
                    return ProjectsScreen(uiModeController: uiModeController);
                  case HomeScreen.routeName:
                  default:
                    return HomeScreen(uiModeController: uiModeController);
                  /////////
                }
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        );
      },
    );
  }
}

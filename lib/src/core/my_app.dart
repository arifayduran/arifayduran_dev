import 'package:arifayduran_dev/src/core/application/scaffold_messenger_key.dart';
import 'package:arifayduran_dev/src/features/projects/presentation/projects_screen.dart';
import 'package:arifayduran_dev/src/features/settings/application/language_provider.dart';
import 'package:arifayduran_dev/src/features/settings/application/routes_service.dart';
import 'package:arifayduran_dev/src/features/settings/application/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/language_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/config/my_custom_scroll_behavior.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/home/presentation/home_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.uiModeController,
  });

  final UiModeController uiModeController;
  final RouteService _routeService = RouteService();
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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
          locale: Provider.of<LanguageProvider>(context).userSelectedLang,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: uiModeController.themeMode,
          initialRoute: "/",
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings routeSettings) {
            currentRoute = routeSettings.name;
            _routeService.updateLastVisitedRoute(routeSettings.name ?? '/');

            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case ProjectsScreen.routeName:
                    return ProjectsScreen(uiModeController: uiModeController);
                  case HomeScreen.routeName:
                  default:
                    return HomeScreen(uiModeController: uiModeController);
                }
              },
            );
          },
        );
      },
    );
  }
}

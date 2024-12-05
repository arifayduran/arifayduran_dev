import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/config/my_custom_scroll_behavior.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/my_portfolio_home.dart';

import '../features/settings/application/settings_controller.dart';

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // showPerformanceOverlay: true,
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          locale: const Locale('en', ''),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // localizationsDelegates: const [
          //   AppLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          // supportedLocales: const [
          //   Locale('en', ''),
          //   Locale('de', ''),
          //   Locale('tr', ''),
          // ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  // case SettingsView.routeName:
                  //   return SettingsView(controller: settingsController);

                  case MyPortfolioHome.routeName:
                  default:
                    return MyPortfolioHome(
                        settingsController: settingsController);
                }
              },
            );
          },
        );
      },
    );
  }
}

import 'package:arifayduran_dev/src/features/settings/application/language_provider.dart';
import 'package:arifayduran_dev/src/features/settings/application/ui_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/config/my_custom_scroll_behavior.dart';
import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/core/my_portfolio_home.dart';
import 'package:provider/provider.dart';

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({
    super.key,
    required this.uiModeController,
  });

  final UiModeController uiModeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: uiModeController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // showPerformanceOverlay: true,
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          locale: Provider.of<LanguageProvider>(context).userSelectedLang,
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
          themeMode: uiModeController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  // case SettingsView.routeName:
                  //   return SettingsView(controller: uiModeController);

                  case MyPortfolioHome.routeName:
                  default:
                    return MyPortfolioHome(uiModeController: uiModeController);
                }
              },
            );
          },
        );
      },
    );
  }
}

import 'package:arifayduran_dev/src/core/presentation/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/language_provider.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/navigation_provider.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/first_launch_service.dart';
import 'package:arifayduran_dev/src/features/settings/application/services/language_service.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'src/core/my_app.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'src/features/settings/application/controllers/ui_mode_controller.dart';
import 'src/features/settings/application/services/ui_mode_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  isPlatformWeb = kIsWeb;
  if (isPlatformWeb) {
    usePathUrlStrategy();
  }
  final uiModeController = UiModeController(UiModeService());
  await uiModeController.loadSettings();

  await LanguageService().getLanguage();
  // await FirstLaunchService().checkFirstLaunch(); // not using for now

  routeHistory = await routeObserver.getRouteHistory();
  initialRoute = routeHistory!.isNotEmpty ? routeHistory!.last : '/';

  myToolbar = MyToolbar(uiModeController: uiModeController);
  // myBottombar = MyBottombar(uiModeController: uiModeController);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ToolbarProvider(),
    ),
    // ChangeNotifierProvider(
    //   create: (context) => BottombarProvider(),
    // ),
  ], child: MyApp(uiModeController: uiModeController)));
}

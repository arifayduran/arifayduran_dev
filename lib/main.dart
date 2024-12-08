import 'package:arifayduran_dev/src/features/settings/application/controllers/language_provider.dart';
// import 'package:arifayduran_dev/src/features/settings/application/services/first_launch_service.dart';
import 'package:arifayduran_dev/src/features/settings/application/services/language_service.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/material.dart';
import 'src/core/my_app.dart';
import 'src/features/settings/application/controllers/ui_mode_controller.dart';
import 'src/features/settings/application/services/ui_mode_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final uiModeController = UiModeController(UiModeService());
  await uiModeController.loadSettings();
  
  await LanguageService().getLanguage();
  // await FirstLaunchService().checkFirstLaunch(); // not using for now


   routeHistory = await routeObserver.getRouteHistory();
  initialRoute = routeHistory!.isNotEmpty ? routeHistory!.last : '/';

  runApp(ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(
        uiModeController: uiModeController
      )));
}

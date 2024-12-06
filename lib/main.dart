import 'package:arifayduran_dev/src/features/settings/application/language_provider.dart';
import 'package:arifayduran_dev/src/features/settings/application/language_service.dart';
import 'package:flutter/material.dart';
import 'src/core/my_app.dart';
import 'src/features/settings/application/ui_mode_controller.dart';
import 'src/features/settings/application/ui_mode_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final uiModeController = UiModeController(UiModeService());
  await uiModeController.loadSettings();
  await LanguageService().getLanguage();


  runApp(ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(uiModeController: uiModeController)));
}

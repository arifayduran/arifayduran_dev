import 'package:flutter/material.dart';
import 'src/core/my_portfolio_app.dart';
import 'src/features/settings/application/settings_controller.dart';
import 'src/features/settings/application/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(MyPortfolioApp(settingsController: settingsController));
}

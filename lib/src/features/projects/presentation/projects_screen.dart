import 'package:arifayduran_dev/src/config/route_links.dart';
import 'package:arifayduran_dev/src/core/application/url_launcher_new_tab.dart';
import 'package:arifayduran_dev/src/features/settings/application/ui_mode_controller.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key, required this.uiModeController});

  final UiModeController uiModeController;
  static const routeName = '/projects';

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final nameStyle = Theme.of(context).textTheme.displayMedium;
    final descriptionStyle = Theme.of(context).textTheme.headlineMedium;

    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/");
              urlLauncherNewTab(wetterAppUrl);
            },
            child: Text(
              "Wetter App",
              style: descriptionStyle?.copyWith(),
            ),
          ),
        ),
      ),
    );
  }
}

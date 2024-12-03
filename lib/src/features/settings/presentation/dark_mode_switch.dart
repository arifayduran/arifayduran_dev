import 'package:flutter/material.dart';
import 'package:arifayduran_dev/src/features/settings/application/settings_controller.dart';
import 'package:rive/rive.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  DarkModeSwitchState createState() => DarkModeSwitchState();
}

class DarkModeSwitchState extends State<DarkModeSwitch> {
  StateMachineController? controller;
  SMIInput<bool>? switchInput;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (switchInput == null) return;
        final isDark = switchInput!.value;
        widget.settingsController.updateThemeMode(
            switchInput!.value ? ThemeMode.light : ThemeMode.dark);
        switchInput?.change(!isDark);
      },
      child: SizedBox(
          height: 50,
          width: 80,
          child: RiveAnimation.asset(
            "assets/animations/darklight-switch.riv",
            stateMachines: const ["Switch Theme"],
            onInit: (artboard) {
              controller = StateMachineController.fromArtboard(
                artboard,
                "Switch Theme",
              );
              if (controller == null) return;
              artboard.addController(controller!);
              switchInput = controller!.findInput("isDark");
              switchInput?.change(widget.settingsController.darkModeSet);
            },
          )),
    );
  }
}

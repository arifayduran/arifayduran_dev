import 'package:flutter/material.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:rive/rive.dart';

class UiModeSwitch extends StatefulWidget {
  const UiModeSwitch({super.key, required this.uiModeController});

  final UiModeController uiModeController;

  @override
  UiModeSwitchState createState() => UiModeSwitchState();
}

class UiModeSwitchState extends State<UiModeSwitch> {
  StateMachineController? controller;
  SMIInput<bool>? switchInput;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (switchInput == null) return;
        final isDark = switchInput!.value;
        widget.uiModeController.updateThemeMode(
            switchInput!.value ? ThemeMode.light : ThemeMode.dark, context);
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
              switchInput?.change(widget.uiModeController.darkModeSet);
            },
          )),
    );
  }
}

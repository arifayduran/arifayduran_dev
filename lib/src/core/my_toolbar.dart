import 'package:arifayduran_dev/src/config/theme.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/language_selector.dart';
import 'package:arifayduran_dev/src/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/ui_mode_switch.dart';
import 'package:provider/provider.dart';

class ToolbarProvider extends ChangeNotifier {
  Color scrolledPlaceColor = effectColorDark;
  double toolbarHeight = maxToolbarHeight;
  Duration duration = const Duration(milliseconds: 1000);

  void updateToolBar(Color color, double height, Duration newDuration) {
    duration = newDuration;
    scrolledPlaceColor = color;
    toolbarHeight = height;

    notifyListeners();
  }
}

class MyToolbar extends StatefulWidget {
  const MyToolbar({super.key, required this.uiModeController});

  final UiModeController uiModeController;

  @override
  State<MyToolbar> createState() => _MyToolbarProvider();
}

class _MyToolbarProvider extends State<MyToolbar> {
  @override
  void initState() {
    super.initState();
    widget.uiModeController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ToolbarProvider toolbarProvider = Provider.of<ToolbarProvider>(context);

    return AnimatedContainer(
      duration: toolbarProvider.duration,
      curve: Curves.easeInOut,
      height: toolbarProvider.toolbarHeight,
      child: AnimatedContainer(
        duration: toolbarProvider.duration,
        curve: Curves.easeInOut,
        color: toolbarProvider.scrolledPlaceColor,
        child: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: toolbarProvider.toolbarHeight,
          // leadingWidth: toolbarHeight,
          leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: widget.uiModeController.darkModeSet
                  ? Image.asset("assets/app_icons/light_transparent.png")
                  : Image.asset("assets/app_icons/dark_transparent.png")),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: TooltipAndSelectable(
                  isTooltip: true,
                  isSelectable: false,
                  message: AppLocalizations.of(context)!.appDescription,
                  child: Text(
                    AppLocalizations.of(context)!.appTitle,
                  ),
                )),
                Flexible(
                    child: TooltipAndSelectable(
                  isTooltip: true,
                  isSelectable: false,
                  message: widget.uiModeController.darkModeSet
                      ? AppLocalizations.of(context)!.toggleHoverToLight
                      : AppLocalizations.of(context)!.toggleHoverToDark,
                  child: UiModeSwitch(
                    uiModeController: widget.uiModeController,
                  ),
                )),
                Flexible(
                  child: LanguageSelector(
                    uiModeController: widget.uiModeController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

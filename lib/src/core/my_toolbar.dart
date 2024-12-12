import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/language_selector.dart';
import 'package:arifayduran_dev/src/widgets/tooltip_and_selectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:arifayduran_dev/src/features/settings/presentation/ui_mode_switch.dart';
import 'package:provider/provider.dart';

class ToolbarState extends ChangeNotifier {
  Color scrolledPlaceColor = Colors.blue;
  double toolbarHeight = maxToolbarHeight;

  void updateAppBar(Color color, double height) {
    scrolledPlaceColor = color;
    toolbarHeight = height;
    notifyListeners();
  }
}

class MyToolbar extends StatelessWidget implements PreferredSizeWidget {
  MyToolbar({super.key});

  final ToolbarState toolbarState = ToolbarState();

  @override
  Size get preferredSize => Size.fromHeight(toolbarState.toolbarHeight);

  @override
  Widget build(BuildContext context) {
    UiModeController uiModeController = Provider.of<UiModeController>(context);
    return AppBar(
      backgroundColor: toolbarState.scrolledPlaceColor,
      toolbarHeight: toolbarState.toolbarHeight,
      // leadingWidth: toolbarHeight,
      leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: uiModeController.darkModeSet
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
              message: uiModeController.darkModeSet
                  ? AppLocalizations.of(context)!.toggleHoverToLight
                  : AppLocalizations.of(context)!.toggleHoverToDark,
              child: UiModeSwitch(
                uiModeController: uiModeController,
              ),
            )),
            Flexible(
              child: LanguageSelector(
                uiModeController: uiModeController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

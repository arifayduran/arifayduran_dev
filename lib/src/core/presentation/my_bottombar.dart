import 'dart:ui';
import 'package:arifayduran_dev/src/features/settings/application/controllers/navigation_provider.dart';
import 'package:arifayduran_dev/src/features/settings/application/controllers/ui_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBottombar extends StatefulWidget {
  const MyBottombar({super.key, required this.uiModeController});

  final UiModeController uiModeController;

  @override
  State<MyBottombar> createState() => _MyBottombarState();
}

class _MyBottombarState extends State<MyBottombar> {
  late ScrollController _scrollController;
  double _itemWidth = 80.0; // Startwert, wird später berechnet

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateItemWidth(); // Berechne Breite nach Abhängigkeiten
  }

  @override
  void didUpdateWidget(covariant MyBottombar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _centerSelectedItem(); // Zentriere nach Widget-Update
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _calculateItemWidth() {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    final String currentNavItem =
        navigationProvider.navItems[navigationProvider.selectedIndex];
    final String localizedText = _getLocalizedText(currentNavItem);

    final textPainter = TextPainter(
      text: TextSpan(
        text: localizedText,
        style: const TextStyle(
          fontSize: 22,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    _itemWidth = textPainter.width + 20; // Breite + Padding

    _centerSelectedItem();
  }

  String _getLocalizedText(String navItem) {
    final localizations = AppLocalizations.of(context)!;
    switch (navItem) {
      case "home":
        return localizations.naviBarHome;
      case "aboutme":
        return localizations.naviBarAboutme;
      case "projects":
        return localizations.naviBarProjects;
      case "contact":
        return localizations.naviBarContact;
      default:
        return ""; // Standardwert oder Fehlerbehandlung
    }
  }

  void _centerSelectedItem() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigationProvider =
          Provider.of<NavigationProvider>(context, listen: false);
      final centerOffset = (navigationProvider.selectedIndex * _itemWidth) -
          (_scrollController.position.viewportDimension / 2) +
          (_itemWidth / 2);

      _scrollController.animateTo(
        centerOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: 80,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .5),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (navigationProvider.selectedIndex > 0)
                IconButton(
                  icon: const Icon(Icons.chevron_left,
                      size: 30, color: Colors.white),
                  onPressed: () {
                    navigationProvider.setIndex(
                        navigationProvider.selectedIndex - 1, context);
                    _centerSelectedItem();
                  },
                ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      navigationProvider.navItems.length, // Nutze navItems hier
                  itemBuilder: (context, index) {
                    bool isSelected = index == navigationProvider.selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        navigationProvider.setIndex(index, context);
                        _centerSelectedItem();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        width: _itemWidth, // Verwende berechnete Breite
                        alignment: Alignment.center,
                        transform: Matrix4.diagonal3Values(
                          isSelected ? 1.3 : 0.9,
                          isSelected ? 1.3 : 0.9,
                          1.0,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: isSelected ? 1.0 : 0.5,
                          child: Text(
                            _getLocalizedText(navigationProvider.navItems[
                                index]), // Lokalisierten Text verwenden
                            style: TextStyle(
                              fontSize: isSelected ? 22 : 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w400,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (navigationProvider.selectedIndex <
                  navigationProvider.navItems.length - 1)
                IconButton(
                  icon: const Icon(Icons.chevron_right,
                      size: 30, color: Colors.white),
                  onPressed: () {
                    navigationProvider.setIndex(
                        navigationProvider.selectedIndex + 1, context);
                    _centerSelectedItem();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

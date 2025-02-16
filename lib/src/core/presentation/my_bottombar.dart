import 'dart:ui';
import 'package:arifayduran_dev/src/features/settings/application/controllers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


SPRACHE STATE OLUYOR MU?

class MyBottombar extends StatelessWidget {
  const MyBottombar({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    final List<String> navItems = ["home", "aboutme", "projects", "contact"];

    final Map<String, String> localizations = {
      "home": AppLocalizations.of(context)!.naviBarHome,
      "aboutme": AppLocalizations.of(context)!.naviBarAboutme,
      "projects": AppLocalizations.of(context)!.naviBarProjects,
      "contact": AppLocalizations.of(context)!.naviBarContact,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            int newIndex =
                (navigationProvider.selectedIndex - 1) % navItems.length;
            navigationProvider.setIndex(
                newIndex < 0 ? navItems.length - 1 : newIndex, context);
          },
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: navItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  return GestureDetector(
                    onTap: () => navigationProvider.setIndex(index, context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: navigationProvider.selectedIndex == index
                            ? Colors.white
                            : Colors.transparent,
                      ),
                      child: Text(
                        localizations[index]!,
                        style: TextStyle(
                          color: navigationProvider.selectedIndex == index
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () {
            int newIndex =
                (navigationProvider.selectedIndex + 1) % navItems.length;
            navigationProvider.setIndex(newIndex, context);
          },
        ),
      ],
    );
  }
}

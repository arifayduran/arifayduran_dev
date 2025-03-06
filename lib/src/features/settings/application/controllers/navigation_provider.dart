import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;
  final List<String> _navItems = ["home", "aboutme", "projects", "contact"];

  int get selectedIndex => _selectedIndex;
  List<String> get navItems => _navItems;

  void setIndex(int index, BuildContext context) {
    _selectedIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/aboutme');
        break;
      case 2:
        Navigator.pushNamed(context, '/projects');
        break;
      case 3:
        Navigator.pushNamed(context, '/contact');
        break;
      default:
        Navigator.pushNamed(context, '/404');
    }
  }
}

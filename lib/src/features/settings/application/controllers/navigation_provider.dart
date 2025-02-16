import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

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

import 'package:flutter/material.dart';

import '../ui/dorama_list_screen.dart';
import '../ui/memo_list_screen.dart';

class BottomNavigationViewModel extends ChangeNotifier {
  final List<Widget> options = [
    DoramaListScreen(),
    MemoListScreen(),
  ];

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void change(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget getSelectedScreen() {
    return options[selectedIndex];
  }
}

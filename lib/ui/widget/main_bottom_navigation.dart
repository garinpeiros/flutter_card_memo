import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/bottom_navigation_view_model.dart';

class MainBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomNavigationModel =
        Provider.of<BottomNavigationViewModel>(context, listen: true);

    return Scaffold(
      body: Center(
        child: bottomNavigationModel.getSelectedScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.title),
            title: Text(
              "ドラマ",
              style: TextStyle(fontSize: 10),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank),
            title: Text(
              'カード',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
        onTap: (index) {
          bottomNavigationModel.change(index);
        },
        currentIndex: bottomNavigationModel.selectedIndex,
        type: BottomNavigationBarType.fixed,
      ),
      //floatingActionButton: AddTodoButton(),
    );
  }
}

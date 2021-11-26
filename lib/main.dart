import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/dorama_form_screen.dart';
import 'ui/memo_form_screen.dart';
import 'ui/widget/main_bottom_navigation.dart';
import 'viewmodels/bottom_navigation_view_model.dart';
import 'viewmodels/dorama_view_model.dart';
import 'viewmodels/memo_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationViewModel>(
          create: (context) => BottomNavigationViewModel(),
        ),
        ChangeNotifierProvider<MemoViewModel>(
          create: (context) => MemoViewModel(),
        ),
        ChangeNotifierProvider<DoramaViewModel>(
          create: (context) => DoramaViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARD MEMO',
      theme: ThemeData(
        fontFamily: 'NotoSerifJP-SemiBold',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainBottomNavigation(),
      routes: {
        MemoFormScreen.id: (context) => MemoFormScreen(),
        DoramaFormScreen.id: (context) => DoramaFormScreen(),
      },
    );
  }
}

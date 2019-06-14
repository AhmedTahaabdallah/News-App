import 'package:flutter/material.dart';
import './screens/onboarding.dart';
import './screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './utillites/app_them.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen');
  Widget _screen;
  if(seen == null || !seen){
    _screen = OnBoarding();
  } else {
    _screen = HomeScreen();
  }
  runApp(NewsApp(_screen));
}

class NewsApp extends StatelessWidget {
  final Widget _screen;
  NewsApp(this._screen);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: this._screen,
      theme: AppThem.appTheme,
    );
  }
}

import 'package:flutter/material.dart';
import '../presentation/pages/pages.dart';

class Routes {
  static const initialRoute = Home.routeName;

  static final Map<String, Widget Function(BuildContext)> routes = {
    Home.routeName: (context) => const Home(),
    PreviousGamesPage.routeName: (context) => const PreviousGamesPage(),
  };
}

import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/form_screen.dart';
import '../screens/detail_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String form = '/form';
  static const String detail = '/detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      form: (context) => const FormScreen(),
      detail: (context) => const DetailScreen(),
    };
  }
}

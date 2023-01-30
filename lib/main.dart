import 'package:burmesedream/common/theme/app_theme.dart';
import 'package:burmesedream/screen/auth_screen/login_screen.dart';
import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: LoginScreen(),
    );
  }
}

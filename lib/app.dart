import 'package:flutter/material.dart';
import 'package:insaaju/routes.dart';
import 'package:insaaju/ui/screen/home/home_screen.dart';
import 'package:insaaju/ui/screen/widget/app_bottom_navigation_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insaaju',
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
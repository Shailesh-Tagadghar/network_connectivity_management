import 'package:flutter/material.dart';
import 'package:network_connectivity_management/Routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute, // Set up the routes
      initialRoute: AppRoutes.home, // Set the initial screen route
    );
  }
}

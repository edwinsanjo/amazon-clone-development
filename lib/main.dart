import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dev Mart',
      // Defining the Theme
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        shadowColor: Colors.green,
        colorScheme:
            const ColorScheme.dark(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
        useMaterial3: true,
      ),
      // Removing the debug banner (only for development)
      debugShowCheckedModeBanner: false,
      // Generating Routes
      onGenerateRoute: (settings) => generateRoute(settings),
      //The Home App
      home: const AuthScreen(),
    );
  }
}

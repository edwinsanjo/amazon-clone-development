import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/features/auth/services/auth_services.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

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
      home: Container(
        child: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const HomeScreen()
            : const AuthScreen(),
      ),
    );
  }
}

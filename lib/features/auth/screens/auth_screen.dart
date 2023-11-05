import 'package:e_commerce_app/common/Widgets/custom_button.dart';
import 'package:e_commerce_app/common/Widgets/custom_textfield.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

// enum for options
enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // defining the enum
  Auth _auth = Auth.signup;

  // keys for form
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();

  // importing the authService
  final AuthService authService = AuthService();

  // Controllers for auth text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    // the widget starts here
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top welcome text
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            // create account radio button
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Create Account",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            // checking to open the form
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signupFormKey,
                  child: Column(children: [
                    CustomTextField(
                        controller: _nameController, hintText: "Name"),
                    CustomTextField(
                        controller: _emailController, hintText: "Email"),
                    CustomTextField(
                        controller: _passwordController, hintText: "Password"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: "Signup",
                        onTap: () {
                          if (_signupFormKey.currentState!.validate()) {
                            signUpUser();
                          }
                        }),
                  ]),
                ),
              ),
            // sign-in raido button
            ListTile(
              tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                "Sign-In",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signinFormKey,
                  child: Column(children: [
                    CustomTextField(
                        controller: _emailController, hintText: "Email"),
                    CustomTextField(
                        controller: _passwordController, hintText: "Password"),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: "Sign In",
                        onTap: () {
                          if (_signinFormKey.currentState!.validate()) {
                            signInUser();
                          }
                        }),
                  ]),
                ),
              ),
            // kjldaslhfjlas
          ],
        ),
      )),
    );
  }
}

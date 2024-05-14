// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messaging_app/pages/components/custom_button.dart';
import 'package:messaging_app/pages/components/custom_textformfield.dart';
import 'package:messaging_app/pages/login/forgot_password_page/forgot_password.dart';
import 'package:messaging_app/pages/ragister/ragisterpage.dart';
import 'package:messaging_app/service/firebase_auth/authentication_check.dart';
import 'package:messaging_app/service/firebase_auth/authentication_service.dart';

//login page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //manage password visiblity
  bool passwordInVisible = true;

  //form global state key
  final _key = GlobalKey<FormState>();

  //object of google signin with email scope
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  //signin user with email password
  void signIn() {
    try {
      AuthenticationService()
          .signInUser(_emailController.text, _passwordController.text)
          .whenComplete(
            () => goToAuth(),
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          SizedBox(
            height: displayHeight / 6,
          ),
          const Icon(
            Icons.message,
            size: 90,
          ),
          const SizedBox(
            height: 18,
          ),
          const Center(
            child: Text(
              "F I R E B A S E   M E S S A G I N G",
              style: TextStyle(
                  fontSize: 20, letterSpacing: 1, fontWeight: FontWeight.bold),
            ),
          ),
          Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    isHideText: false,
                    hintText: "Enter Email",
                    prefixIcon: Icons.email_outlined,
                    suffixIcon: null,
                    onIconPressed: null,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    isHideText: passwordInVisible,
                    hintText: "Enter Password",
                    prefixIcon: Icons.password,
                    suffixIcon: passwordInVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    onIconPressed: () {
                      setState(() {
                        passwordInVisible = !passwordInVisible;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomButton(
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        signIn();
                      }
                    },
                    buttonName: "LOGIN",
                    iconData: Icons.login,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      )
                    ],
                  ),
                  CustomButton(
                    onTap: () {
                      AuthenticationService().googleSignin(context).whenComplete(() => goToAuth());
                    },
                    buttonName: "GOOGLE",
                    iconData: Icons.mail,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RagisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Don't have an account Click Hear!",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  goToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthCheck(),
      ),
    );
  }
}

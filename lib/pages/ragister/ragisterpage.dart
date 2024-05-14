import 'package:flutter/material.dart';
import 'package:messaging_app/pages/components/custom_button.dart';
import 'package:messaging_app/pages/components/custom_textformfield.dart';
import 'package:messaging_app/pages/components/dialog_exception.dart';
import 'package:messaging_app/pages/homepage/homepage.dart';
import 'package:messaging_app/service/firebase_auth/authentication_service.dart';

class RagisterPage extends StatefulWidget {
  const RagisterPage({super.key});

  @override
  State<RagisterPage> createState() => _RagisterPageState();
}

class _RagisterPageState extends State<RagisterPage> {
  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //manage password visiblity
  bool visibleInPassword = true;

  //form key
  final _key = GlobalKey<FormState>();

  //match password
  bool _matchPassword() {
    return _passwordController.text == _confirmPasswordController.text
        ? true
        : false;
  }

  //signup with email and password
  void signUp() {
    try {
      AuthenticationService()
          .signUpUser(_emailController.text.toString(),
              _passwordController.text.toString())
          .whenComplete(
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                )),
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
        appBar: AppBar(),
        body: ListView(
          children: [
            SizedBox(
              height: displayHeight / 8,
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
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
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
                        isHideText: visibleInPassword,
                        hintText: "Enter Password",
                        prefixIcon: Icons.password,
                        suffixIcon: visibleInPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onIconPressed: () {
                          setState(() {
                            visibleInPassword = !visibleInPassword;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextFormField(
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.text,
                        isHideText: visibleInPassword,
                        hintText: "Enter Confirm Password",
                        prefixIcon: Icons.password,
                        suffixIcon: visibleInPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        onIconPressed: () {
                          setState(() {
                            visibleInPassword = !visibleInPassword;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomButton(
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            if (!_matchPassword()) {
                              showException(
                                context,
                                "Password Doesn't Match",
                              );
                            } else {
                              signUp();
                            }
                          }
                        },
                        buttonName: "RAGISTER",
                        iconData: Icons.account_circle_outlined,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Already have an account click hear!",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}

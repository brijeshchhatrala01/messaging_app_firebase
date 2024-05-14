import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/pages/components/custom_button.dart';
import 'package:messaging_app/pages/components/custom_textformfield.dart';
import 'package:messaging_app/pages/components/dialog_exception.dart';
import 'package:messaging_app/service/firebase_auth/authentication_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //controller
  final _emailController = TextEditingController();

  //key for form
  final _key = GlobalKey<FormState>();

  //forgot password method
  void forgotPassword() {
    try {
      AuthenticationService().sendLinkToResetPassword(_emailController.text);
    } on FirebaseAuthException catch (e) {
      showException(context, e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    //get device height
    double displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(),
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
                      CustomButton(
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            forgotPassword();
                            Navigator.pop(context);
                          }
                        },
                        buttonName: "FORGOT PASSWORD",
                        iconData: Icons.contact_mail_outlined,
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}

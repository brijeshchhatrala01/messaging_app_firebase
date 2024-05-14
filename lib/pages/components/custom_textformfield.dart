import 'package:flutter/material.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';


//custom textformfield
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isHideText;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onIconPressed;
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.isHideText,
      required this.hintText,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.onIconPressed});

  //check weather textformfields empty or not
  String? checkEmptyValidator(String? value) {
    return value!.isEmpty ? 'please enter required fields' : null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isHideText,
      validator: checkEmptyValidator,
      cursorColor: screenPickerColor,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        //make error border as per user selected color
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: screenPickerColor),
            borderRadius: BorderRadius.circular(12)),
        //make error text as per user selected color
        errorStyle: TextStyle(color: screenPickerColor),
        //make focused error border as per user selected color and thick
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: screenPickerColor, width: 2),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: screenPickerColor, width: 2),
            borderRadius: BorderRadius.circular(12)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed: onIconPressed,
          icon: Icon(suffixIcon),
        ),
      ),
    );
  }
}

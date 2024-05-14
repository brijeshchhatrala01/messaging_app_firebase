import 'package:flutter/material.dart';
import 'package:messaging_app/pages/components/custom_button.dart';

showException(BuildContext context, String error,) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(error),
        actions: [
          CustomButton(
              onTap: () {
                Navigator.pop(context);
              },
              buttonName: "OK",
              iconData: Icons.arrow_back)
        ],
      );
    },
  );
}

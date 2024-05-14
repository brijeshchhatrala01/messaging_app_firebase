import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/custom_button.dart';

//Theme page
class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

Color screenPickerColor = Colors.blue;

class _ThemePageState extends State<ThemePage> {
  @override
  void initState() {
    //set user's choice color of theme
    saveColor();
    super.initState();
  }

  late SharedPreferences userColor;
  late bool isSet;
  //save theme color
  void saveColor() async {
    userColor = await SharedPreferences.getInstance();
    isSet = userColor.getBool('colorSet') ?? true;

    if (!isSet) {
      screenPickerColor = Color(userColor.getInt('color')!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Card(
                elevation: 2,
                child: ColorPicker(
                  // Use the screenPickerColor as start color.
                  color: screenPickerColor,
                  // Update the screenPickerColor using the callback.
                  onColorChanged: (Color color) => setState(() {
                    screenPickerColor = color;
                    userColor.setInt('color', screenPickerColor.value);
                    userColor.setBool('colorSet', false);
                  }),
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  heading: Text(
                    'Select color',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subheading: Text(
                    'Select color shade',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomButton(
                onTap: () {
                  //print(userColor.getInt('color').toString());
                },
                buttonName: "C H A N G E",
                iconData: Icons.color_lens),
          )
        ],
      ),
    );
  }
}

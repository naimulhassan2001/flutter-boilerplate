import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_boilerplate/view/common_widgets/button/common_button.dart';
import 'package:flutter_boilerplate/view/common_widgets/other_widgets/common_loader.dart';
=======
import 'package:flutter_boilerplate/view/common_widgets/button/custom_button.dart';
import 'package:flutter_boilerplate/view/common_widgets/custom_button_loader.dart';
>>>>>>> 2549ed6079da91cbacb2737d53b6e546746db39e

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
<<<<<<< HEAD
            child: CommonButton(
                titleText: "titleText",
                onTap: () {
                  const CommonLoader();
                  setState(() {});
=======
            child: CustomButton(
                titleText: "titleText",
                onPressed: () {
                  const CustomButtonLoader();
                  setState(() {

                  });
>>>>>>> 2549ed6079da91cbacb2737d53b6e546746db39e
                })));
  }
}

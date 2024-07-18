import 'package:flutter/material.dart';
import '../common_widgets/button/common_button.dart';
import '../common_widgets/other_widgets/common_loader.dart';

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
            child: CommonButton(
                titleText: "titleText",
                onTap: () {
                  const CommonLoader();
                  setState(() {});
                })));
  }
}

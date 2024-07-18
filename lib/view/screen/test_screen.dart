import 'package:flutter/material.dart';
import '../../utils/app_string.dart';
import '../component/button/common_button.dart';
import '../component/other_widgets/common_loader.dart';

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
                titleText: AppString.test,
                onTap: () {
                  const CommonLoader();
                  setState(() {});
                })));
  }
}

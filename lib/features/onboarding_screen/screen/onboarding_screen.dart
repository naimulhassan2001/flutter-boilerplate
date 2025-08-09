import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_untitled/features/language/screen/language_screen.dart';
import 'package:new_untitled/features/onboarding_screen/screen/onboarding_one.dart';
import 'package:new_untitled/features/onboarding_screen/screen/onboarding_three.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/extensions/extension.dart';
import '../../../../../utils/constants/app_images.dart';
import '../../../../../utils/constants/app_string.dart';
import '../../../component/button/common_button.dart';
import '../../../component/image/common_image.dart';
import 'onboarding_two.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      LanguageScreen(currentIndex: _currentIndex, controller: _pageController),
      OnboardingOne(currentIndex: _currentIndex, controller: _pageController),
      OnboardingTwo(currentIndex: _currentIndex, controller: _pageController),
      OnboardingThree(currentIndex: _currentIndex, controller: _pageController),
    ];
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ),

            // Buttons
          ],
        ),
      ),
    );
  }
}

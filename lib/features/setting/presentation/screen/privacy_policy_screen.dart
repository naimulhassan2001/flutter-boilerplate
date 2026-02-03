import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../component/other_widgets/common_loader.dart';
import '../../../../component/screen/error_screen.dart';
import '../../../../component/text/common_text.dart';

import '../controller/privacy_policy_controller.dart';
import '../../../../../../utils/constants/app_string.dart';
import '../../../../../../utils/enum/enum.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// App bar
      appBar: AppBar(
        title: const CommonText(
          text: AppString.privacyPolicy,
          fontSize: 20,
          fontWeight: .w600,
        ),
      ),

      /// Body
      body: GetBuilder<PrivacyPolicyController>(
        builder: (controller) => switch (controller.status) {
          /// Loading
          Status.loading => const CommonLoader(),

          /// Error
          Status.error => ErrorScreen(onTap: controller.getPrivacyPolicy),

          /// Completed
          Status.completed => SingleChildScrollView(
            padding: .symmetric(vertical: 24.h, horizontal: 20.w),
            child: Html(data: controller.data.content),
          ),
        },
      ),
    );
  }
}

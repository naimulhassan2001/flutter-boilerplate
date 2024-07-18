
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../../controllers/common_controller/setting/privacy_policy_controller.dart';
import '../../../../models/api_response_model.dart';
import '../../../../utils/app_string.dart';
import '../../../component/other_widgets/common_loader.dart';
import '../../../component/screen/error_screen.dart';
import '../../../component/text/common_text.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const CommonText(
            text: AppString.privacyPolicy,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: GetBuilder<PrivacyPolicyController>(
            builder: (controller) => switch (controller.status) {
                  Status.loading => const CommonLoader(),
                  Status.error => ErrorScreen(
                      onTap: PrivacyPolicyController.instance
                          .getPrivacyPolicyRepo()),
                  Status.completed => SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 20),
                      child: Column(
                        children: [
                          Html(data: controller.data.content),
                        ],
                      ),
                    ),
                }));
  }
}

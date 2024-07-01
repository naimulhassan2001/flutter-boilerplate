
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/view/common_widgets/other_widgets/common_loader.dart';
import 'package:flutter_boilerplate/view/common_widgets/text/common_text.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/common_controller/setting/terms_of_services_controller.dart';
import '../../../../models/api_response_model.dart';
import '../../../common_widgets/screen/error_screen.dart';

class TermsOfServicesScreen extends StatelessWidget {
  const TermsOfServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: CommonText(
            text: "Terms of services".tr,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: GetBuilder<TermsOfServicesController>(
            builder: (controller) => switch (controller.status) {
              Status.loading => const CommonLoader(),
              Status.error => ErrorScreen(
                  onTap: TermsOfServicesController.instance
                      .geTermsOfServicesRepo()),
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

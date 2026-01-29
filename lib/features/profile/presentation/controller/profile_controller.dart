import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/helpers/other_helper.dart';

class ProfileController extends GetxController {
  /// Language List here
  List<String> languages = ['English', 'French', 'Arabic'];

  /// form key here
  final formKey = GlobalKey<FormState>();

  /// select Language here
  String selectedLanguage = 'English';

  /// select image here
  String? image;

  /// edit button loading here
  bool isLoading = false;

  /// all controller here
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  /// select image function here
  Future<void> getProfileImage() async {
    image = await OtherHelper.pickImage();
    update();
  }

  /// select language  function here
  void selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// update profile function here
  Future<void> editProfileRepo() async {
    if (!formKey.currentState!.validate()) return;

    if (!LocalStorage.isLogIn) return;
    isLoading = true;
    update();

    final body = {
      'fullName': nameController.text,
      'phone': numberController.text,
    };

    final response = await ApiService.multipart(
      ApiEndPoint.user,
      body: body,
      imagePath: image,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'] ?? {};

      LocalStorage.userId = data['_id'] ?? '';
      LocalStorage.myImage = data['image'] ?? '';
      LocalStorage.myName = data['fullName'] ?? '';
      LocalStorage.myEmail = data['email'] ?? '';

      LocalStorage.setString('userId', LocalStorage.userId);
      LocalStorage.setString('myImage', LocalStorage.myImage);
      LocalStorage.setString('myName', LocalStorage.myName);
      LocalStorage.setString('myEmail', LocalStorage.myEmail);

      AppSnackbar.success(
        title: 'Successfully Profile Updated',
        message: response.message,
      );
      Get.toNamed(AppRoutes.profile);
    } else {
      AppSnackbar.error(
        title: response.statusCode.toString(),
        message: response.message,
      );
    }

    isLoading = false;
    update();
  }
}

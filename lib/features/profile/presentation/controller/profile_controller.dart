import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:untitled/services/api/multipart_helper.dart';

import '../../../../config/api/api_end_point.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../services/api/api_service.dart';
import '../../../../services/storage/storage_services.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/helpers/other_helper.dart';

class ProfileController extends GetxController {
  /// Language list
  final List<String> languages = ['English', 'French', 'Arabic'];
  String selectedLanguage = 'English';
  String? image;
  bool isLoading = false;

  /// Text controllers
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  /// Pick profile image
  Future<void> getProfileImage() async {
    image = await OtherHelper.pickImage();
    update();
  }

  /// Select language
  void selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  /// Set loading safely
  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  /// Update profile
  Future<void> editProfileRepo() async {
    if (LocalStorage.token.isEmpty) return;

    try {
      _setLoading(true);

      final body = {
        'fullName': nameController.text.trim(),
        'phone': numberController.text.trim(),
      };

      final files = image != null
          ? [MultipartFileItem(fileName: 'image', filePath: image!)]
          : <MultipartFileItem>[];

      final response = await ApiService.multipart(
        url: ApiEndPoint.user,
        body: body,
        files: files,
      );

      if (response.statusCode != 200) {
        throw Exception(response.message);
      }

      final Map<String, dynamic> data = response.data['data'] ?? {};

      LocalStorage.saveUser(data['user']);

      AppSnackbar.success(
        title: 'Success',
        message: 'Profile updated successfully',
      );

      nameController.clear();
      numberController.clear();
      Get.offNamed(AppRoutes.profile);
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      _setLoading(false);
    }
  }

  /// Dispose controllers
  @override
  void onClose() {
    nameController.dispose();
    numberController.dispose();
    super.onClose();
  }
}

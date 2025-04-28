import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_untitled/utils/helpers/other_helper.dart';


class ProfileController extends GetxController {
  List languages = ["English", "French", "Arabic"];
  List gender = const ["Male", "Female", "Other"];

  String selectedLanguage = "English";
  String? image;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



  selectedGender(int index) {
    genderController.text = gender[index].toString();
    update();
    Get.back();
  }

  getProfileImage() async {
    image = await OtherHelper.openGalleryForProfile();
    update();
  }

  selectLanguage(int index) {
    selectedLanguage = languages[index];
    update();
    Get.back();
  }

  Future<void> editProfileRepo() async {
    if (!TokenServices.isLogIn) return;
    isLoading = true;
    update();

    Map<String, String> body = {
      "fullName": nameController.text,
      "phone": numberController.text,
    };

    var response = await ApiService.multipart(
      ApiEndPoint.user,
      body: body,
      imagePath: image,
      imageName: "image",
    );

    if (response.statusCode == 200) {
      Utils.successSnackBar("Successfully Profile Updated", response.message);
      Get.toNamed(AppRoutes.profile);
    } else {
      Utils.errorSnackBar(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}

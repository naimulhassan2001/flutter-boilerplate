import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../config/route/app_routes.dart';

class SignInController extends GetxController {
  /// Sign in Button Loading variable
  bool isLoading = false;

  /// Sign in form key , help for Validation
  final formKey = GlobalKey<FormState>();

  /// email and password Controller here
  final TextEditingController emailController = .new();
  final TextEditingController passwordController = .new();

  /// Sign in Api call here

  Future<void> signInUser() async {
    if (!formKey.currentState!.validate()) return;
    Get.toNamed(AppRoutes.profile);
    return;

    isLoading = true;
    update();

    /// TODO : need to Uncomment

    // final Map<String, String> body = {
    //   'email': emailController.text,
    //   'password': passwordController.text,
    // };

    // final response = await ApiService.post(ApiEndPoint.signIn, body: body);

    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> data = Map<String, dynamic>.from(
    //     response.data,
    //   );
    //   LocalStorage.token = data['data']['accessToken'];
    //   LocalStorage.userId = data['data']['attributes']['_id'];
    //   LocalStorage.myImage = data['data']['attributes']['image'];
    //   LocalStorage.myName = data['data']['attributes']['fullName'];

    //   LocalStorage.myEmail = data['data']['attributes']['email'];
    //   LocalStorage.isLogIn = true;

    //   LocalStorage.setBool(LocalStorageKeys.isLogIn, LocalStorage.isLogIn);
    //   LocalStorage.setString(LocalStorageKeys.token, LocalStorage.token);
    //   LocalStorage.setString(LocalStorageKeys.userId, LocalStorage.userId);
    //   LocalStorage.setString(LocalStorageKeys.myImage, LocalStorage.myImage);
    //   LocalStorage.setString(LocalStorageKeys.myName, LocalStorage.myName);
    //   LocalStorage.setString(LocalStorageKeys.myEmail, LocalStorage.myEmail);

    //   // if (LocalStorage.myRole == 'consultant') {
    //   //   Get.offAllNamed(AppRoutes.doctorHome);
    //   // } else {
    //   //   Get.offAllNamed(AppRoutes.patientsHome);
    //   // }

    //   emailController.clear();
    //   passwordController.clear();
    // } else {
    //   Get.snackbar(response.statusCode.toString(), response.message);
    // }

    isLoading = false;
    update();
  }
}

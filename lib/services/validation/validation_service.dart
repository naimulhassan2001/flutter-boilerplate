import 'package:flutter_boilerplate/utils/constants/app_string.dart';

class ValidationService {
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');

  static String? validator(value) {
    if (value.isEmpty) {
      return AppString.thisFieldIsRequired;
    } else {
      return null;
    }
  }

  static String? emailValidator(
    value,
  ) {
    if (value!.isEmpty) {
      return AppString.thisFieldIsRequired;
    } else if (!emailRegexp.hasMatch(value)) {
      return AppString.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? passwordValidator(value) {
    if (value.isEmpty) {
      return AppString.thisFieldIsRequired;
    } else if (value.length < 8) {
      return AppString.passwordMustBeeEightCharacters;
    } else if (!passRegExp.hasMatch(value)) {
      return AppString.passwordMustBeeEightCharacters;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(value, passwordController) {
    if (value.isEmpty) {
      return AppString.thisFieldIsRequired;
    } else if (value != passwordController.text) {
      return AppString.thePasswordDoesNotMatch;
    } else {
      return null;
    }
  }
}

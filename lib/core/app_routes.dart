
import 'package:get/get.dart';

import '../view/screen/common_screen/auth/change_password/change_password_screen.dart';
import '../view/screen/common_screen/auth/forgot password/create_password.dart';
import '../view/screen/common_screen/auth/forgot password/forgot_password.dart';
import '../view/screen/common_screen/auth/forgot password/verify_screen.dart';
import '../view/screen/common_screen/auth/sign in/sign_in_screen.dart';
import '../view/screen/common_screen/auth/sign up/sign_up_screen.dart';
import '../view/screen/common_screen/auth/sign up/verify_user.dart';
import '../view/screen/common_screen/message/chat_screen.dart';
import '../view/screen/common_screen/message/message_screen.dart';
import '../view/screen/common_screen/notifications/notifications_screen.dart';
import '../view/screen/common_screen/onboarding_screen/onboarding_screen.dart';
import '../view/screen/common_screen/profile/edit_profile.dart';
import '../view/screen/common_screen/profile/profile_screen.dart';
import '../view/screen/common_screen/setting/privacy_policy_screen.dart';
import '../view/screen/common_screen/setting/setting_screen.dart';
import '../view/screen/common_screen/setting/terms_of_services_screen.dart';
import '../view/screen/common_screen/splash/splash_screen.dart';
import '../view/screen/test_screen.dart';

class AppRoutes {
  static const String test = "/test_screen.dart";
  static const String splash = "/splash_screen.dart";
  static const String onboarding = "/onboarding_screen.dart";
  static const String signUp = "/sign_up_screen.dart";
  static const String verifyUser = "/verify_user.dart";
  static const String signIn = "/sign_in_screen.dart";
  static const String forgotPassword = "/forgot_password.dart";
  static const String verifyEmail = "/verify_screen.dart";
  static const String createPassword = "/create_password.dart";
  static const String changePassword = "/change_password_screen.dart";
  static const String notifications = "/notifications_screen.dart";
  static const String chat = "/chat_screen.dart";
  static const String message = "/message_screen.dart";
  static const String profile = "/profile_screen.dart";
  static const String editProfile = "/edit_profile.dart";
  static const String privacyPolicy = "/privacy_policy_screen.dart";
  static const String termsOfServices = "/terms_of_services_screen.dart";
  static const String setting = "/setting_screen.dart";

  static List<GetPage> routes = [
    GetPage(name: test, page: () => TestScreen()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: signUp, page: () => SignUpScreen()),
    GetPage(name: verifyUser, page: () => VerifyUser()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: verifyEmail, page: () => VerifyScreen()),
    GetPage(name: createPassword, page: () => CreatePassword()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: notifications, page: () => NotificationScreen()),
    GetPage(name: chat, page: () => ChatListScreen()),
    GetPage(name: message, page: () => MessageScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: editProfile, page: () => EditProfile()),
    GetPage(name: privacyPolicy, page: () => PrivacyPolicyScreen()),
    GetPage(name: termsOfServices, page: () => TermsOfServicesScreen()),
    GetPage(name: setting, page: () => SettingScreen()),



  ];
}

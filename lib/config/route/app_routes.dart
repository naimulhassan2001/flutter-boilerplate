import '../../view/view.dart';

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
    GetPage(
        name: test,
        page: () => const TestScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: onboarding,
        page: () => const OnboardingScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: signUp,
        page: () => SignUpScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: verifyUser,
        page: () => const VerifyUser(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: signIn,
        page: () => SignInScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: forgotPassword,
        page: () => ForgotPasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: verifyEmail,
        page: () => const VerifyScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: createPassword,
        page: () => CreatePassword(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: changePassword,
        page: () => ChangePasswordScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: notifications,
        page: () => const NotificationScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: chat,
        page: () => const ChatListScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: message,
        page: () => const MessageScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: profile,
        page: () => const ProfileScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: editProfile,
        page: () => EditProfile(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: privacyPolicy,
        page: () => const PrivacyPolicyScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: termsOfServices,
        page: () => const TermsOfServicesScreen(),
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: setting,
        page: () => const SettingScreen(),
        transition: Transition.rightToLeftWithFade),
  ];
}

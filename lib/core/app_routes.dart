import 'package:get/get.dart';

import '../view/screen/test_screen.dart';


class AppRoutes {
  static const String test = "/test_screen.dart";


  static List<GetPage> routes = [
    GetPage(name: test, page: () => TestScreen()),

  ];
}

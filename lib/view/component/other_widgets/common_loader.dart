import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key, this.size = 60});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.sp,
      width: size.sp,
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    );
  }
}

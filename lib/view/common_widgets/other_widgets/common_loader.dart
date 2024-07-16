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
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

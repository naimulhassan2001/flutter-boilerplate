import 'package:flutter/material.dart';


class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.size = 60});

  final double size;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator()
    );
  }
}

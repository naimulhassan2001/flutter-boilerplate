import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth ;

  const CustomButton(
      {this.onPressed,
      required this.titleText,
      this.titleColor = AppColors.white,
      this.buttonColor = AppColors.primaryColor,
      this.titleSize = 16,
      this.buttonRadius = 10,
      this.titleWeight = FontWeight.w700,
      this.buttonHeight = 60,
      this.borderWidth = 1,
      this.buttonWidth= double.infinity,
      this.borderColor = AppColors.primaryColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius),
                side: BorderSide(
                    color: borderColor ?? AppColors.primaryColor,
                    width: borderWidth),
              ),
            ),
            elevation: MaterialStateProperty.all(0)),
        child: Text(
          titleText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
              color: titleColor, fontSize: titleSize, fontWeight: titleWeight),
        ),
      ),
    );
  }
}

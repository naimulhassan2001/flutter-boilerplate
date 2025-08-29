
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';
import '../other_widgets/common_loader.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double buttonWidth;
  final bool isLoading;

  const CommonButton({
    this.onTap,
    required this.titleText,
    this.titleColor = AppColors.white,
    this.buttonColor = AppColors.primaryColor,
    this.titleSize = 16,
    this.buttonRadius = 10,
    this.titleWeight = FontWeight.w700,
    this.buttonHeight = 60,
    this.borderWidth = 1,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.borderColor = AppColors.primaryColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight.h,
      width: buttonWidth.w,
      child: _buildElevatedButton(),
    );
  }

  // Function to build the button with common settings
  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: onTap,
      style: _buttonStyle(),
      child: isLoading ? _buildLoader() : _buildText(),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(buttonColor),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius.r),
          side: BorderSide(
            color: borderColor ?? AppColors.primaryColor,
            width: borderWidth.w,
          ),
        ),
      ),
      elevation: WidgetStateProperty.all(0),
    );
  }

  Widget _buildLoader() {
    return CommonLoader(
      size: buttonHeight - 10,
    );
  }

  Widget _buildText() {
    return Text(
      titleText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: GoogleFonts.roboto(
        color: titleColor,
        fontSize: titleSize.sp,
        fontWeight: titleWeight,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors.dart';
import '../text/custom_text.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.hintText,
      this.labelText,
      this.prefixSvgIcon,
      this.isPassword = false,
      this.controller,
      this.textInputAction = TextInputAction.next,
      this.keyboardType = TextInputType.text,
      this.mexLength,
      this.validator,
      this.prefixText,
      this.paddingHorizontal,
      this.paddingVertical,
      this.inputFormatters,
      this.fillColor = AppColors.grey800,
      this.hintTextColor = AppColors.white50,
      this.labelTextColor = AppColors.white50,
      this.textColor = AppColors.white50,
      this.borderColor = AppColors.transparent,
      this.onSubmitted,
      this.onTap,
      this.suffixIcon});

  final String? hintText;
  final String? labelText;
  final Widget? prefixSvgIcon;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputAction textInputAction;
  final FormFieldValidator? validator;
  final TextInputType keyboardType;
  final int? mexLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? labelTextColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color borderColor;
  final String? prefixText;

  final double? paddingHorizontal;

  final double? paddingVertical;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;


  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      textInputAction: widget.textInputAction,
      maxLength: widget.mexLength,
      cursorColor: AppColors.white50,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(fontSize: 14.sp, color: widget.textColor),
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        prefixIcon: widget.prefixSvgIcon,
        fillColor: widget.fillColor,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(
            horizontal: widget.paddingHorizontal ?? 16.w,
            vertical: widget.paddingVertical ?? 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        hintText: widget.hintText,
        labelText: widget.labelText,
        hintStyle:
            GoogleFonts.roboto(fontSize: 14.sp, color: widget.hintTextColor),
        labelStyle:
            GoogleFonts.roboto(fontSize: 14.sp, color: widget.labelTextColor),
        prefix: CustomText(
          text: widget.prefixText ?? "",
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: toggle,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 10.w),
                  child: obscureText
                      ? Icon(
                          Icons.visibility_off_outlined,
                          size: 20.sp,
                          color: widget.textColor,
                        )
                      : Icon(
                          Icons.visibility_outlined,
                          color: widget.textColor,
                          size: 20.sp,
                        ),
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}

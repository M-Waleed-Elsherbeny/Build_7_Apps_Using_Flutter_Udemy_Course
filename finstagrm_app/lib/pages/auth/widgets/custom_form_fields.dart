// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormFields extends StatelessWidget {
  const CustomFormFields({
    super.key,
    required this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.validator,
    this.controller,
    this.onSaved,
    this.suffixIcon,
    this.onPressed,
    this.isPassword = false,
  });
  final String hintText;
  final String labelText;
  final Widget? prefixIcon, suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final bool isPassword;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      obscureText: isPassword ? true : false,
      keyboardType:
          isPassword
              ? TextInputType.visiblePassword
              : TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(fontSize: 15.sp, color: Colors.black),
        prefixIcon: prefixIcon,
        suffixIcon:
            !isPassword && suffixIcon != null
                ? suffixIcon
                : IconButton(
                  icon: Icon(
                    isPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: onPressed,
                ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.5.w),
        ),
      ),
    );
  }
}

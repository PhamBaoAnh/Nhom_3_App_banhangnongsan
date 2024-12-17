import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CostomTextFormFild extends StatelessWidget {
  CostomTextFormFild({
    Key? key,
    required this.hint,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    required this.prefixIcon,
    this.filled = false,
    this.fillColor = Colors.transparent, // Màu nền mặc định là trong suốt
    this.enabled = true,
    this.initialValue,
    this.readOnly = false,  // Thêm thuộc tính readOnly
  }) : super(key: key);

  String hint;
  IconData prefixIcon;
  IconData? suffixIcon;
  VoidCallback? onTapSuffixIcon;
  bool obscureText;
  bool filled;
  Color fillColor;
  bool enabled;
  String? initialValue;
  bool readOnly; // Khai báo biến readOnly

  TextEditingController? controller;
  Function()? onEditingComplete;

  String? Function(String?)? validator;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: initialValue,
        onEditingComplete: onEditingComplete,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        keyboardType: TextInputType.emailAddress,
        readOnly: readOnly, // Sử dụng readOnly ở đây
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            borderSide: const BorderSide(color: TColors.darkGrey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            borderSide: const BorderSide(color: TColors.darkGrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            borderSide: const BorderSide(color: TColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            borderSide: const BorderSide(color: Colors.red),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: TColors.darkGrey,
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              color: TColors.primary,
              size: 20,
            ),
            onPressed: onTapSuffixIcon,
          ),
          filled: filled,
          fillColor: fillColor, // Thêm thuộc tính fillColor
          enabled: enabled,
        ),
      ),
    );
  }
}

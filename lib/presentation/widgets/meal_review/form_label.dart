import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';

class FormLabel extends StatelessWidget {
  final String text;

  const FormLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'DM Sans',
        color: AppColors.textPrimary,
      ),
    );
  }
}

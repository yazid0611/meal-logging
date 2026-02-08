import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';

class PickerUtils {
  static ThemeData getPickerTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      colorScheme: const ColorScheme.light(primary: AppColors.primary),
    );
  }

  static Future<DateTime?> selectDate(
    BuildContext context, {
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(2030),
      builder: (context, child) {
        return Theme(data: getPickerTheme(context), child: child!);
      },
    );
  }

  static Future<TimeOfDay?> selectTime(
    BuildContext context, {
    required TimeOfDay initialTime,
  }) async {
    return await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(data: getPickerTheme(context), child: child!);
      },
    );
  }
}

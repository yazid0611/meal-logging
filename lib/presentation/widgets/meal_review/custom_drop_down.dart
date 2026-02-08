import 'package:flutter/material.dart';
import 'package:meal_logging/core/constants/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? labelText;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? hintText;

  const CustomDropdown({
    super.key,
    this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              fontFamily: 'DM Sans',
            ),
          ),
          const SizedBox(height: 8),
        ],
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              dropdownColor: AppColors.surface,
              hint: hintText != null
                  ? Text(
                      hintText!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textHint,
                        fontFamily: 'DM Sans',
                      ),
                    )
                  : null,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontFamily: 'DM Sans',
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

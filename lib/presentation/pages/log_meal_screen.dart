import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_logging/core/constants/app_colors.dart';
import 'package:meal_logging/core/navigation/route_name.dart';
import 'package:meal_logging/core/utils/ui_utils.dart';
import 'package:meal_logging/presentation/widgets/shared/app_button.dart';
import 'package:meal_logging/presentation/widgets/shared/custom_bar.dart';
import 'package:meal_logging/presentation/widgets/log_meal/meal_description_text_field.dart';
import 'package:meal_logging/presentation/widgets/log_meal/info_hint_card.dart';

class LogMealScreen extends StatelessWidget {
  const LogMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final descriptionController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'Log Breakfast'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Describe what you ate by voice or text',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'DM Sans',
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const InfoHintCard(
                      message: 'For more precise logging, describe individual ingredients and portions.',
                    ),
                    const SizedBox(height: 20),
                    MealDescriptionTextField(
                      controller: descriptionController,
                      hintText: 'Example: "1 chicken breast, 3 tbsps pesto sauce, 2 cups of whole grain pasta"',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: PrimaryButton(
            text: 'Done',
            onPressed: () => onDonePressed(context, descriptionController),
          ),
        ),
      ),
    );
  }

  void onDonePressed(BuildContext context, TextEditingController controller) {
    final description = controller.text.trim();
    if (description.isEmpty) {
      UIUtils.showError(context, 'Please enter a meal description');
      return;
    }
    context.pushNamed(RouteName.mealReview, extra: {'prompt': description});
  }
}
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';

class SubscriptionItem extends StatelessWidget {
  const SubscriptionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .33,
      child: Card(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text('Plan name', style: context.labelLarge.w600),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Amount', style: context.titleLarge.w600),
                    TextSpan(text: '/month', style: context.labelMedium.w600),
                  ],
                ),
              ),
              AppButton(
                label: 'Choose Plan',
                onPressed: () {},
                width: double.maxFinite,
                borderRadius: BorderRadius.circular(30),
                textStyle: context.labelMedium.w600.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_table.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:gap/gap.dart';

class SubscriptionSuccessPage extends StatelessWidget {
  const SubscriptionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: ''),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(30),
              Text('Payment is successful', style: context.headlineMedium.w600),
              Gap(10),
              Text(
                'your subscription is now active. Welcome to Video summerize',
                style: context.labelLarge,
              ),
              Gap(50),
              AppTable(
                tableItems: [
                  TableRowItem(title: 'Plan Name', content: 'Free'),
                  TableRowItem(title: 'billing cycle', content: '1 month'),
                  TableRowItem(title: 'Price', content: '0'),
                ],
                tableTitle: 'Subscription plan detail',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

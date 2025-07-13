import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/panel_cubit.dart';
import 'package:frontend/features/subscriptions/presentation/widgets/faq_item.dart';
import 'package:frontend/features/subscriptions/presentation/widgets/subscription_item.dart';
import 'package:gap/gap.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Summarizer'),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1100),
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Wrap(
                children: [
                  SubscriptionItem(),
                  SubscriptionItem(),
                  SubscriptionItem(),
                ],
              ),
              Gap(30),
              Text('Frequently asked question', style: context.titleLarge.w900),
              Gap(30),
              BlocProvider(
                create: (context) => PanelCubit(),
                child: BlocConsumer<PanelCubit, int>(
                  listener: (context, state) {},
                  builder: (context, state) => ListView.separated(
                    separatorBuilder: (context, index) => Gap(16),
                    itemBuilder: (context, index) => FaqItem(),
                    physics: ClampingScrollPhysics(),
                    itemCount: 10,
                    shrinkWrap: true,
                  ),
                ),
              ),
              Gap(30),
              Wrap(
                spacing: 30,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  AppButton(
                    label: 'Terms of Service',
                    type: CustomButtonType.text,
                    textStyle: context.labelMedium.copyWith(
                      color: AppColors.mutedForeground,
                    ),
                    onPressed: () {},
                  ),
                  AppButton(
                    label: 'Privacy Policy',
                    type: CustomButtonType.text,
                    textStyle: context.labelMedium.copyWith(
                      color: AppColors.mutedForeground,
                    ),
                    onPressed: () {},
                  ),
                  AppButton(
                    label: 'Contact us',
                    type: CustomButtonType.text,
                    textStyle: context.labelMedium.copyWith(
                      color: AppColors.mutedForeground,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

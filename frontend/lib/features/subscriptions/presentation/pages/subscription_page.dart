import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/Subscription_state.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/panel_cubit.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/subscription_bloc.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/subscription_event.dart';
import 'package:frontend/features/subscriptions/presentation/widgets/faq_item.dart';
import 'package:frontend/features/subscriptions/presentation/widgets/subscription_item.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  SubscriptionBloc subscriptionBloc = SubscriptionBloc();

  @override
  void initState() {
    super.initState();
    subscriptionBloc.add(GetPlans());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: subscriptionBloc,
      child: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: CommonAppBar(title: 'Summarizer'),
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: state.apiStatus.isLoading
                  ? SubscriptionScreenShimmer()
                  : ListView(
                      padding: EdgeInsets.all(20),
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 450),
                          child: PageView.builder(
                            itemCount: state.plans.length,
                            scrollDirection: Axis.horizontal,
                            padEnds: false,
                            controller: PageController(viewportFraction: .3),
                            itemBuilder: (context, index) {
                              var item = state.plans.elementAt(index);
                              return SubscriptionItem(planModel: item);
                            },
                          ),
                        ),
                        Gap(30),
                        Text(
                          'Frequently asked question',
                          style: context.titleLarge.w900,
                        ),
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
        ),
      ),
    );
  }
}

class SubscriptionScreenShimmer extends StatelessWidget {
  const SubscriptionScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Shimmer for PageView (Subscription Items)
          SizedBox(
            height: 450, // Adjust height to match your SubscriptionItem
            child: PageView.builder(
              itemCount: 3,
              // Display a few shimmer items
              scrollDirection: Axis.horizontal,
              padEnds: false,
              controller: PageController(viewportFraction: .3),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // Adjust as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200,
                        // Approximate height of SubscriptionItem content
                        color: Colors.white,
                      ),
                      const Gap(10),
                      Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                      ),
                      const Gap(5),
                      Container(width: 150, height: 20, color: Colors.white),
                    ],
                  ),
                );
              },
            ),
          ),
          const Gap(30),
          // Shimmer for "Frequently asked question" Text
          Container(
            width: 250,
            height: 24, // Approximate height of the text
            color: Colors.white,
          ),
          const Gap(30),
          // Shimmer for FAQ Items
          ListView.separated(
            separatorBuilder: (context, index) => const Gap(16),
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 40, // Approximate height of FaqItem
                  color: Colors.white,
                ),
              ],
            ),
            physics: const NeverScrollableScrollPhysics(),
            // Disable scrolling for shimmer
            itemCount: 5,
            // Display a few shimmer FAQ items
            shrinkWrap: true,
          ),
          const Gap(30),
          // Shimmer for Bottom Buttons (optional, could be simpler)
          Wrap(
            spacing: 30,
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(
              3,
              (index) => Container(width: 100, height: 30, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

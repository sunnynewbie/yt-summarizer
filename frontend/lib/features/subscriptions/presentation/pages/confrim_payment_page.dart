import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/converters/app_size.dart';
import 'package:frontend/core/utils/pref_util.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_icon_button.dart';
import 'package:frontend/core/widgets/app_table.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/confirm_payment/confirm_payment_bloc.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/confirm_payment/confirm_payment_event.dart';
import 'package:frontend/features/subscriptions/presentation/bloc/confirm_payment/confirm_payment_state.dart';
import 'package:frontend/network/api_service.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage({super.key});

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  ConfirmPaymentBloc confirmPaymentBloc = ConfirmPaymentBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final parameter = GoRouterState.of(context).uri.queryParameters;
      if (parameter.containsKey('id')) {
        confirmPaymentBloc.add(GetSinglePlanEvent(parameter['id'] ?? ''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: confirmPaymentBloc,
      child: Scaffold(
        appBar: CommonAppBar(title: 'YT-summarize'),
        body: BlocConsumer<ConfirmPaymentBloc, ConfirmPaymentState>(
          listener: (context, state) {},
          builder: (context, state) => Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: state.apiStatus.isLoading
                  ? ConfirmPaymentPageShimmer()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            children: [
                              Gap(30),
                              Text(
                                'Confirm your subscription',
                                style: context.headlineLarge.w600,
                              ),
                              Gap(30),
                              AppTable(
                                tableItems: [
                                  TableRowItem(
                                    title: 'Plan Name',
                                    content: state.planModel?.plan_name ?? '',
                                  ),
                                  TableRowItem(
                                    title: 'billing cycle',
                                    content: '1 month',
                                  ),
                                  TableRowItem(
                                    title: 'Price',
                                    content: '${state.planModel?.price ?? '0'}',
                                  ),
                                ],
                                tableTitle: 'Plan summary',
                              ),
                              Gap(50),
                              Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    BlocSelector<
                                      ConfirmPaymentBloc,
                                      ConfirmPaymentState,
                                      ApiStatus
                                    >(
                                      selector: (state) => state.apiStatus,
                                      builder: (context, apiStatus) => AppButton(
                                        label: 'Go to payment',
                                        elevation: 0,
                                        isLoading:
                                            apiStatus.isUserActionLoading,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        onPressed: () {
                                          var user =
                                              SharedPrefsHelper.getUser();
                                          if (user != null) {
                                            confirmPaymentBloc.add(
                                              StartSubscriptionEvent(
                                                state.planModel!.id,
                                                user.id,
                                              ),
                                            );
                                          }
                                          // context.go(AppRoutes.successPage);
                                        },
                                        textStyle:
                                            context.labelMedium.w600.white,
                                        width: context.isMobile
                                            ? context.width
                                            : 200,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Gap(30),
                                Text(
                                  'Plan Benefits',
                                  style: context.labelLarge.w600,
                                ),
                                Gap(30),
                                _PaymentBenefitItem(
                                  title: 'Plan title 1',
                                  description: 'Description 1',
                                ),
                                Gap(10),
                                _PaymentBenefitItem(
                                  title: 'Plan title 1',
                                  description: 'Description 1',
                                ),
                                Gap(10),
                                _PaymentBenefitItem(
                                  title: 'Plan title 1',
                                  description: 'Description 1',
                                ),
                              ],
                            ),
                          ),
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

class _PaymentBenefitItem extends StatelessWidget {
  final String title;
  final String description;

  const _PaymentBenefitItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIconButton(
        shape: ButtonShape.roundedRectangle,
        backgroundColor: AppColors.border,
        child: Icon(Icons.stars_rounded),
        onPressed: () {},
        borderRadius: 10,
      ),
      title: Text(title, style: context.labelLarge.w600),
      subtitle: Text(description, style: context.labelMedium.grey),
    );
  }
}

class ConfirmPaymentPageShimmer extends StatelessWidget {
  const ConfirmPaymentPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shimmer for the Left Side (Plan Details)
            Expanded(
              flex: 2,
              child: ListView(
                children: [
                  const Gap(30),
                  // Shimmer for "Confirm your subscription" Text
                  Container(
                    width: 300, // Approximate width
                    height: 32, // Approximate height of headlineLarge
                    color: Colors.white,
                  ),
                  const Gap(20),
                  // Shimmer for "Plan summary" Text
                  Container(
                    width: 150, // Approximate width
                    height: 20, // Approximate height of bodyLarge
                    color: Colors.white,
                  ),
                  const Gap(30),
                  // Shimmer for AppTable
                  _buildShimmerTable(context),
                  const Gap(50),
                  // Shimmer for "Go to payment" Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: context.isMobile ? context.width * 0.8 : 200,
                      height: 48, // Approximate button height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  const Gap(20), // Extra space at the bottom
                ],
              ),
            ),
            const Gap(20), // Spacer between columns
            // Shimmer for the Right Side (Plan Benefits)
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(30),
                    // Shimmer for "Plan Benefits" Text
                    Container(
                      width: 150, // Approximate width
                      height: 20, // Approximate height of labelLarge
                      color: Colors.white,
                    ),
                    const Gap(30),
                    // Shimmer for PaymentBenefitItems
                    _buildShimmerBenefitItem(context),
                    const Gap(10),
                    _buildShimmerBenefitItem(context),
                    const Gap(10),
                    _buildShimmerBenefitItem(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerTable(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100, // Approximate width for title
                height: 16, // Approximate height for text
                color: Colors.white,
              ),
              Container(
                width: 150, // Approximate width for content
                height: 16, // Approximate height for text
                color: Colors.white,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildShimmerBenefitItem(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40, // Approximate size of AppIconButton
        height: 40, // Approximate size of AppIconButton
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      title: Container(
        width: 120, // Approximate width
        height: 18, // Approximate height of labelLarge
        color: Colors.white,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Container(
          width: 180, // Approximate width
          height: 14, // Approximate height of labelMedium
          color: Colors.white,
        ),
      ),
    );
  }
}

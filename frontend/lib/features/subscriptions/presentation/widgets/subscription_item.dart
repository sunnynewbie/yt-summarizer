import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/features/subscriptions/domain/entities/plan_model.dart';
import 'package:go_router/go_router.dart';

class SubscriptionItem extends StatelessWidget {
  final PlanModel planModel;

  const SubscriptionItem({super.key, required this.planModel});

  @override
  Widget build(BuildContext context) {
    return Card(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(planModel.plan_name, style: context.titleMedium.w600),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${planModel?.price ?? '0'}',
                            style: context.titleLarge.w600,
                          ),
                          TextSpan(
                            text:
                                '/${planModel.video_limit} minutes or ${planModel.video_limit} videos',
                            style: context.labelLarge.w600,
                          ),
                        ],
                      ),
                    ),
                    Html(
                      data: planModel.plan_content,
                      style: {
                        "ul": Style(
                          margin: Margins.symmetric(horizontal: 10),
                          padding: HtmlPaddings.symmetric(horizontal: 12),
                        ),
                        "li": Style(
                          fontSize: FontSize(14,Unit.px),
                          padding: HtmlPaddings.only(bottom: 6),
                        ),
                        "h3": Style(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.xxLarge,
                          color: Colors.blueAccent,
                          padding: HtmlPaddings.only(bottom: 12),
                        ),
                      },
                    ),
                  ],
                ),
              ],
            ),
            AppButton(
              label: 'Choose Plan',
              onPressed: () {
                context.goNamed(
                  AppRoutes.confrimPlan,
                  queryParameters: {'id': planModel.id.toString()},
                );
              },
              width: double.maxFinite,
              borderRadius: BorderRadius.circular(30),
              textStyle: context.labelMedium.w600.white,
            ),
          ],
        ),
      ),
    );
  }
}

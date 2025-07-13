import 'package:flutter/material.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/core/widgets/image_view.dart';
import 'package:frontend/features/auth/presentation/widgets/register_form.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'YT- summarizer',
        actions: [
          AppButton(
            label: 'Login in',
            onPressed: () {
              context.go(AppRoutes.login);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15).copyWith(left: 20, right: 20),
        child: Row(
          spacing: 30,
          children: [
            Expanded(
              flex: 1,
              child: RegisterForm(),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summarize YouTube Videos with AI',
                    style: TextStyle().s20.w600,
                  ),
                  Gap(10),
                  Text(
                    'Unlock the power of efficient learning'
                        ' with our AI-driven video summarizer.'
                        ' Transform lengthy videos into concise summaries,'
                        ' saving you time and enhancing your understanding.'
                        ' Sign up today and experience a smarter way'
                        ' to consume video content.',
                    style: TextStyle().s16,
                  ),
                  Gap(5),
                  Expanded(
                    child: ImageView(
                      imageType: ImageType.asset,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                      imagePath: 'assets/image/image2.png',
                    ),
                  ),
                  Gap(30)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

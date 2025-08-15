import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/converters/app_size.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/core/widgets/image_view.dart';
import 'package:frontend/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit loginCubit = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginCubit,
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'YT- summarizer',
          actions: [
            AppButton(
              label: 'Sign up',
              onPressed: () {
                context.go(AppRoutes.signup);
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15).copyWith(left: 20, right: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.sizeOf(context).width,
                maxHeight: MediaQuery.sizeOf(context).height,
              ),
              child: context.isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        contentWidget(context),
                        Expanded(child: LoginForm()),
                      ],
                    )
                  : Row(
                      spacing: 30,
                      children: [
                        Expanded(
                          flex: context.isTablet ? 1 : 1,
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height,
                            child: LoginForm(),
                          ),
                        ),
                        Expanded(
                          flex: context.isTablet ? 1 : 2,
                          child: contentWidget(context),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget contentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summarize YouTube Videos with AI', style: TextStyle().s20.w600),
        Gap(10),
        Text(
          'Get concise summaries of lengthy '
          'YouTube videos instantly.'
          ' Save time and quickly grasp the key points of'
          ' any video with our AI-powered summarizer.',
          style: TextStyle().s16,
        ),
        Gap(5),
        if (!context.isMobile)
          Expanded(
            child: ImageView(
              imageType: ImageType.asset,
              width: double.maxFinite,
              fit: BoxFit.cover,
              imagePath: 'assets/image/image1.png',
            ),
          ),
        Gap(30),
      ],
    );
  }
}

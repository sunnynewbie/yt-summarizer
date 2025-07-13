import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_text_field.dart';
import 'package:gap/gap.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Expanded(
          flex: 4,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: [
              Text(
                'Login into your account',
                style: TextStyle().s22.w900,
                textAlign: TextAlign.center,
              ),
              Gap(30),
              AppTextField(
                hintText: 'Email address',
                keyboardType: TextInputType.emailAddress,
                filled: true,
              ),
              Gap(20),
              AppTextField(
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                filled: true,
                obscureText: true,),
              Gap(30),
              AppButton(label: 'Login', onPressed: () {}),
              Gap(10),
              AppButton(
                label: 'Login with google',
                type: CustomButtonType.outline,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

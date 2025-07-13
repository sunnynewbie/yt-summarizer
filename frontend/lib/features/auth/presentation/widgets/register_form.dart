import 'package:flutter/material.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_text_field.dart';
import 'package:gap/gap.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Expanded(
            flex: 4,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              children: [
                Text(
                  'Create your account',
                  style: TextStyle().s22.w900,
                  textAlign: TextAlign.center,
                ),
                Gap(30),
                AppTextField(
                  filled: true,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap(20),
                AppTextField(filled: true, hintText: 'Name'),
                Gap(20),
                AppTextField(
                  filled: true,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                ),
                Gap(30),
                AppButton(label: 'Register', onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

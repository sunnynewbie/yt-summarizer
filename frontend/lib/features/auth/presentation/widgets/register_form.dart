import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/utils/regex_manager.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_text_field.dart';
import 'package:frontend/features/auth/presentation/bloc/register/register_cubit.dart';
import 'package:frontend/features/auth/presentation/bloc/register/register_state.dart';
import 'package:frontend/features/auth/presentation/widgets/password_icon_button.dart';
import 'package:gap/gap.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) => Column(
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
                    controller: context.read<RegisterCubit>().emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isNotEmail) {
                        return 'Invalid email';
                      }
                    },
                  ),
                  Gap(20),
                  AppTextField(
                    filled: true,
                    hintText: 'Name',
                    controller: context.read<RegisterCubit>().nameCtrl,
                    validator: (value) {
                      if (value!.isNotName) {
                        return 'Invalid name';
                      }
                    },
                  ),
                  Gap(20),
                  AppTextField(
                    filled: true,
                    hintText: 'Password',
                    obscureText: context
                        .watch<RegisterCubit>()
                        .state
                        .passwordVisible,
                    controller: context.read<RegisterCubit>().passwordCtrl,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isNotPassword) {
                        return 'Invalid password';
                      }
                    },
                    suffixIcon:
                        BlocSelector<RegisterCubit, RegisterState, bool>(
                          selector: (state) => state.passwordVisible,
                          builder: (context, state) => PasswordIconButton(
                            isVisible: state,
                            onClick: () {
                              context
                                  .read<RegisterCubit>()
                                  .changePasswordVisibility();
                            },
                          ),
                        ),
                  ),
                  Gap(30),
                  AppButton(
                    label: 'Register',
                    isLoading: state.apiStatus.isUserActionLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        context.read<RegisterCubit>().register();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

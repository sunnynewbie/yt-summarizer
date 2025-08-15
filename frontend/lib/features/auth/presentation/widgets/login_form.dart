import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/regex_manager.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_text_field.dart';
import 'package:frontend/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:frontend/features/auth/presentation/bloc/login/login_state.dart';
import 'package:frontend/features/auth/presentation/widgets/password_icon_button.dart';
import 'package:frontend/network/api_service.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
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
                  controller: context.read<LoginCubit>().emailCtrl,
                  validator: (value) {
                    if (value!.isNotEmail) {
                      return 'Invalid email';
                    }
                  },
                  filled: true,
                ),
                Gap(20),
                AppTextField(
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  filled: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) {
                    goToLogin();
                  },
                  suffixIcon: BlocSelector<LoginCubit, LoginState, bool>(
                    selector: (state) => state.showPassword,
                    builder: (context, state) => PasswordIconButton(
                      isVisible: state,
                      onClick: () {
                        context.read<LoginCubit>().togglePassword();
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value!.isNotPassword) {
                      return 'Invalid password';
                    }
                  },
                  controller: context.read<LoginCubit>().passCtrl,
                  obscureText: context.watch<LoginCubit>().state.showPassword,
                ),
                Gap(30),
                BlocSelector<LoginCubit, LoginState, ApiStatus>(
                  selector: (state) => state.apiStatus,
                  builder: (context, state) => AppButton(
                    label: 'Login',
                    isLoading: state.isUserActionLoading,
                    onPressed: () {
                      goToLogin();
                    },
                  ),
                ),
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
      ),
    );
  }

  goToLogin() async {
    if (formkey.currentState?.validate()??true) {
      var response = await context.read<LoginCubit>().login();
      var loginCubit = context.read<LoginCubit>();
      if (loginCubit.state.apiStatus.isSuccess) {
        context.goNamed(AppRoutes.home);
      }
    }
  }
}

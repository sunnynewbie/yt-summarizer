import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/app_icon_button.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/features/home/presentation/bloc/sidebar_cuibt.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../widgets/app_menu_item.dart';

class HomePage extends StatefulWidget {
  final Widget shelRoute;

  const HomePage({super.key, required this.shelRoute});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formKey = GlobalKey<FormState>();
  var urlCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SidebarCubit(context),
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Summarize',
          actions: [
            AppCustomButton(
              child: Icon(Icons.attach_money_rounded, color: AppColors.primary),
              onPressed: () {
                context.go(AppRoutes.subscriptions);
              },
            ),
            AppButton(
              height: 35,
              label: 'User name',
              textStyle: context.labelMedium.w600.primary,
              icon: CircleAvatar(),
              onPressed: () {},
              padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
              type: CustomButtonType.outlineWithIcon,
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.primaryForeground),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<SidebarCubit, AppMenu>(
                listener: (context, state) {},
                builder: (context, state) => ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 210),
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppMenuItem(
                        title: 'Home',
                        leading: Icon(Icons.home_rounded),
                        onTap: () {
                          BlocProvider.of<SidebarCubit>(
                            context,
                          ).selectMenu(AppMenu.home);
                          context.go(AppRoutes.home);
                        },
                        selected: state == AppMenu.home,
                      ),
                      AppMenuItem(
                        title: 'History',
                        leading: Icon(Icons.history_rounded),
                        onTap: () {
                          BlocProvider.of<SidebarCubit>(
                            context,
                          ).selectMenu(AppMenu.history);

                          context.go(AppRoutes.history);
                        },
                        selected: state == AppMenu.history,
                      ),
                      AppMenuItem(
                        title: 'Settings',
                        leading: Icon(Icons.settings_rounded),
                        onTap: () {
                          BlocProvider.of<SidebarCubit>(
                            context,
                          ).selectMenu(AppMenu.settings);

                          context.go(AppRoutes.settings);
                        },
                        selected: state == AppMenu.settings,
                      ),
                    ],
                  ),
                ),
              ),
              Gap(10),
              Expanded(child: widget.shelRoute),
            ],
          ),
        ),
      ),
    );
  }
}

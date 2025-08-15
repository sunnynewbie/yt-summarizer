import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/pref_util.dart';
import 'package:frontend/core/utils/text_style.dart';
import 'package:frontend/core/widgets/app_button.dart';
import 'package:frontend/core/widgets/common_app_bar.dart';
import 'package:frontend/features/home/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:frontend/features/home/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:frontend/features/home/presentation/bloc/dashboard/dashboard_state.dart';
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
  DashboardBloc dashboardBloc = DashboardBloc();
  final GlobalKey<PopupMenuButtonState> _menuKey =
      GlobalKey<PopupMenuButtonState>();

  @override
  void initState() {
    super.initState();
    dashboardBloc.add(BootstrapEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: dashboardBloc),
        BlocProvider(create: (context) => SidebarCubit(context)),
      ],
      child: BlocListener<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        listener: (context, state) {
          if (state.apiStatus.isUnAuthenticated) {
            SharedPrefsHelper.clear().whenComplete(
              () => context.go(AppRoutes.login),
            );
          }
        },
        child: Scaffold(
          appBar: CommonAppBar(
            title: 'Summarize',
            actions: [
              AppButton(
                height: 35,
                icon: Icon(
                  Icons.attach_money_rounded,
                  color: AppColors.primary,
                ),
                type: CustomButtonType.outlineWithIcon,
                label: 'Upgrade plan',
                onPressed: () {
                  context.go(AppRoutes.subscriptions);
                },
              ),
              Gap(15),
              PopupMenuButton(
                key: _menuKey,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    height: 38,
                    onTap: () async {
                      await SharedPrefsHelper.clear();
                      context.replace(AppRoutes.login);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout_rounded),
                        Gap(10),
                        Text('Logout', style: context.labelSmall),
                      ],
                    ),
                  ),
                ],
                position: PopupMenuPosition.under,
                child:
                    BlocSelector<DashboardBloc, DashboardState, DashboardState>(
                      selector: (state) => state,
                      builder: (context, state) => AppButton(
                        height: 35,
                        label: state.userModel?.name ?? '',
                        isLoading: state.apiStatus.isLoading,
                        textStyle: context.labelMedium.w600.primary,
                        icon: CircleAvatar(
                          child: Text(
                            state.userModel?.name.substring(0, 1) ?? '',
                          ),
                        ),
                        onPressed: state.apiStatus.isLoading
                            ? null
                            : () {
                                _menuKey.currentState!.showButtonMenu();
                              },
                        padding: EdgeInsets.only(
                          right: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        type: CustomButtonType.outlineWithIcon,
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: AppColors.primaryForeground,
                        ),
                      ),
                    ),
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
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/route_util/app_routes.dart';
import 'package:go_router/go_router.dart';

enum AppMenu {
  home(AppRoutes.home),
  history(AppRoutes.history),
  settings(AppRoutes.settings);

  final String route;

  const AppMenu(this.route);
}

class SidebarCubit extends Cubit<AppMenu> {
  AppMenu seletedMenu = AppMenu.home;

  SidebarCubit(BuildContext context) : super(AppMenu.home) {
    if (GoRouter.of(context).state.path == AppMenu.home.route) {
      selectMenu(AppMenu.home);
    } else if (GoRouter.of(context).state.path == AppMenu.history.route) {
      selectMenu(AppMenu.history);
    } else if (GoRouter.of(context).state.path == AppMenu.settings.route) {
      selectMenu(AppMenu.settings);
    }
  }

  void selectMenu(AppMenu menu) {
    seletedMenu = menu;
    emit(seletedMenu);
  }
}

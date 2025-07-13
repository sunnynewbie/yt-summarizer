import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:frontend/core/route_util/route_setup.dart';
import 'package:frontend/core/utils/app_colors.dart';
import 'package:frontend/core/utils/app_theme.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouteSetup(Uri.base.path).appRoute,
      debugShowCheckedModeBanner: false,
      title: 'YT summarizer',
      theme: AppTheme.light.copyWith(
        expansionTileTheme: ExpansionTileThemeData(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.border, width: .5),
            borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: AppColors.card,
        ),
      ),
    );
  }
}

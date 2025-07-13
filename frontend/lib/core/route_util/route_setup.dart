import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/features/auth/presentation/pages/login_page.dart';
import 'package:frontend/features/auth/presentation/pages/register_page.dart';
import 'package:frontend/features/history/presentation/pages/history_page.dart';
import 'package:frontend/features/home/presentation/pages/home_page.dart';
import 'package:frontend/features/settings/presentation/pages/settings_page.dart';
import 'package:frontend/features/subscriptions/presentation/pages/subscription_page.dart';
import 'package:frontend/features/transcript/presentation/widgets/summary_page.dart';
import 'package:go_router/go_router.dart';

class RouteSetup {
  final String path;

  RouteSetup(this.path);

  GoRouter get appRoute => GoRouter(
    initialLocation: path,
    routes: [
      GoRoute(path: AppRoutes.login, builder: (context, state) => LoginPage()),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.transcript,
        builder: (context, state) => SummaryPage(),
      ),
      GoRoute(
        path: AppRoutes.subscriptions,
        builder: (context, state) => SubscriptionPage(),
      ),
      ShellRoute(
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => SummaryPage(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => SettingsPage(),
          ),
          GoRoute(
            path: AppRoutes.history,
            builder: (context, state) => HistoryPage(),
          ),
        ],
        builder: (context, state, child) => HomePage(shelRoute: child),
      ),
    ],
  );
}

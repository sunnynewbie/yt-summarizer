import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/core/utils/pref_util.dart';
import 'package:frontend/features/auth/presentation/pages/login_page.dart';
import 'package:frontend/features/auth/presentation/pages/register_page.dart';
import 'package:frontend/features/history/presentation/pages/history_page.dart';
import 'package:frontend/features/home/presentation/pages/home_page.dart';
import 'package:frontend/features/settings/presentation/pages/settings_page.dart';
import 'package:frontend/features/subscriptions/presentation/pages/add_payment_page.dart';
import 'package:frontend/features/subscriptions/presentation/pages/confrim_payment_page.dart';
import 'package:frontend/features/subscriptions/presentation/pages/subscription_page.dart';
import 'package:frontend/features/subscriptions/presentation/pages/subscription_success_page.dart';
import 'package:frontend/features/transcript/presentation/widgets/summary_page.dart';
import 'package:go_router/go_router.dart';

class RouteSetup {
  final String path;

  RouteSetup(this.path);

  GoRouter get appRoute => GoRouter(
    initialLocation: path,
    redirect: (context, state) {
      final token = SharedPrefsHelper.getToken();
      if (token == null) {
        return AppRoutes.login;
      } else {
        if (state.fullPath == null || state.fullPath == '/') {
          return AppRoutes.home;
        }
        return null;
      }
    },
    routes: [
      GoRoute(
        name: AppRoutes.login,
        path: AppRoutes.login,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        name: AppRoutes.signup,
        path: AppRoutes.signup,
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        name: AppRoutes.transcript,
        path: AppRoutes.transcript,
        builder: (context, state) => SummaryPage(),
      ),
      GoRoute(
        path: AppRoutes.subscriptions,
        name: AppRoutes.subscriptions,
        builder: (context, state) => SubscriptionPage(),
      ),
      ShellRoute(
        routes: [
          GoRoute(
            path: AppRoutes.home,
            name: AppRoutes.home,
            builder: (context, state) => SummaryPage(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            name: AppRoutes.settings,
            builder: (context, state) => SettingsPage(),
          ),
          GoRoute(
            path: AppRoutes.history,
            name: AppRoutes.history,
            builder: (context, state) => HistoryPage(),
          ),
        ],
        builder: (context, state, child) => HomePage(shelRoute: child),
      ),
      GoRoute(
        path: AppRoutes.addPaymentPage,
        name: AppRoutes.addPaymentPage,
        builder: (context, state) => AddPaymentPage(),
      ),
      GoRoute(
        path: AppRoutes.confrimPlan,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'];
          print(id);
          return ConfirmPaymentPage();
        },
      ),
      GoRoute(
        path: AppRoutes.successPage,
        name: AppRoutes.successPage,
        builder: (context, state) => SubscriptionSuccessPage(),
      ),
    ],
  );
}

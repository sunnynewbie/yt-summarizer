import 'package:frontend/core/route_util/app_routes.dart';
import 'package:frontend/features/transcript/presentation/widgets/summary_page.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';

class RouteSetup {
  GoRouter appRoute = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(path: AppRoutes.home, builder: (context, state) => HomePage()),
      GoRoute(
        path: AppRoutes.transcript,
        builder: (context, state) => SummaryPage(),
      ),
    ],
  );
}

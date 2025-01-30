import 'package:go_router/go_router.dart';

import 'features/accounts/login_screen.dart';
import 'features/root_screen.dart';

final GoRouter myRouter = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => RootScreen(),
    ),
  ]
);

import 'package:go_router/go_router.dart';

import './features/accounts/login_screen.dart';
import './features/root_screen.dart';
import './my_widgets/image_view.dart';  

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

    GoRoute(
      path: '/image-view',
      builder: (context, state) {
        final url = state.extra as String;
        return ImageView(url: url);
      }
    ),
  ]
);

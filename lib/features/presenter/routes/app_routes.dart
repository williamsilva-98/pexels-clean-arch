import 'package:go_router/go_router.dart';
import 'package:pexels_clean_arch/features/presenter/pages/home/home_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);

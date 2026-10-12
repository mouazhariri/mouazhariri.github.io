import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/portfolio/presentation/screens/portfolio_screen.dart';
import '../../core/utils/extensions/context_extension.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) => AppRouter.build();

/// Single-page portfolio: one route, graceful fallback for anything else.
abstract class AppRouter {
  const AppRouter._();

  static GoRouter build() {
    return GoRouter(
      initialLocation: AppRoutes.home,
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: PortfolioScreen(),
          ),
        ),
      ],
      errorBuilder: (context, state) => const FallbackScreen(),
    );
  }
}

/// 404 screen for unknown paths.
class FallbackScreen extends StatelessWidget {
  const FallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.travel_explore_rounded, size: 72),
            const SizedBox(height: 12),
            Text('404', style: context.text.displayMedium),
            const Text('This page does not exist.'),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Back to home'),
            ),
          ],
        ),
      ),
    );
  }
}
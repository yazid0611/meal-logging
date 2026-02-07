import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_logging/core/navigation/route_path.dart';

class AppRouter {
  AppRouter._();

  static final router = GoRouter(
    initialLocation: RoutePath.home,
    debugLogDiagnostics: true,
    routes: [],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.name}'))),
  );
}

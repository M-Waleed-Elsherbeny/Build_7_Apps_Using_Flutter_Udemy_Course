import 'package:finstagrm_app/core/router/app_route.dart';
import 'package:finstagrm_app/pages/auth/login_page.dart';
import 'package:finstagrm_app/pages/auth/register_page.dart';
import 'package:finstagrm_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class AppRouteConfig {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoute.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppRoute.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(child: Text('Page not found ${settings.name}')),
              ),
        );
    }
  }
}

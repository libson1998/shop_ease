import 'package:flutter/material.dart';
import 'package:shope_ease/base/app_base.dart';
import 'package:shope_ease/ui/checkout/checkout_screen.dart';
import 'package:shope_ease/ui/details_screen/details_screen.dart';
import 'package:shope_ease/ui/login/login_screen.dart';
import 'package:shope_ease/ui/order/order_history.dart';
import 'package:shope_ease/ui/order/order_success_screen.dart';
import 'package:shope_ease/ui/search/search_screen.dart';
import 'package:shope_ease/ui/signup/signup_screen.dart';
import 'package:shope_ease/utils/screen_error.dart';

class RouteGenerator {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/LoginScreen":
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case "/AppBase":
        return MaterialPageRoute(
          builder: (context) => const AppBase(),
        );
      case "/SignupScreen":
        return MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        );
      case "/OrderHistoryScreen":
        return MaterialPageRoute(
          builder: (context) => const OrderHistoryScreen(),
        );

      case '/DetailsScreen':
        if (args is List) {
          return MaterialPageRoute(
              builder: (_) => DetailsScreen(
                    product: args[0],
                    navigateTo: args[1],
                  ));
        } else {
          return MaterialPageRoute(
            builder: (_) => const ErrorScreen(
              title: 'Error',
            ),
          );
        }
      case '/OrderSuccessScreen':
        if (args is List) {
          return MaterialPageRoute(
              builder: (_) => OrderSuccessScreen(
                    navigateTo: args[0],
                  ));
        } else {
          return MaterialPageRoute(
            builder: (_) => const ErrorScreen(
              title: 'Error',
            ),
          );
        }
      case '/SearchScreen':
        if (args is List) {
          return MaterialPageRoute(
              builder: (_) =>
                  SearchScreen(products: args[0], navigateTo: args[1]));
        } else {
          return MaterialPageRoute(
            builder: (_) => const ErrorScreen(
              title: 'Error',
            ),
          );
        }
      case '/CheckoutScreen':
        if (args is List) {
          return MaterialPageRoute(
              builder: (_) => CheckoutScreen(
                    products: args[0],
                    homeBloc: args[1],
                    navigateTo: args[2],
                  ));
        } else {
          return MaterialPageRoute(
            builder: (_) => const ErrorScreen(
              title: 'Error',
            ),
          );
        }
    }
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:shope_ease/base/app_base.dart';

import 'package:shope_ease/ui/login/login_screen.dart';

import 'package:shope_ease/ui/post/create_post/create_post_screen.dart';
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
      case "/CreatePostScreen":
        return MaterialPageRoute(
          builder: (context) => const CreatePostScreen(),
        );
    }
    return null;
  }
}

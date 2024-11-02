import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope_ease/network/bloc/home_bloc/home_bloc.dart';
import 'package:shope_ease/network/bloc/login_bloc/login_bloc.dart';
import 'package:shope_ease/network/bloc/profile/profile_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/signup/auth_bloc.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/utils/routes.dart';
import 'package:shope_ease/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(PreferenceConstants.isLoggedIn) ?? false;
  runApp(MyApp(
    loggedIn: loggedIn,
  ));
}

class MyApp extends StatefulWidget {
  final bool loggedIn;

  const MyApp({super.key, required this.loggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RouteGenerator _routeGenerator = RouteGenerator();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop Ease',
        theme: appTheme,
        initialRoute: widget.loggedIn ? '/AppBase' : '/LoginScreen',
        onGenerateRoute: _routeGenerator.generateRoute,
      ),
    );
  }
}

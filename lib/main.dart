import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope_ease/firebase_options.dart';
import 'package:shope_ease/network/bloc/login_bloc/login_bloc.dart';
import 'package:shope_ease/network/bloc/profile/profile_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/news_feeds/news_feeds_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/post/post_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/signup/auth_bloc.dart';
import 'package:shope_ease/notification/local_notification.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/utils/routes.dart';
import 'package:shope_ease/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Make sure this is properly configured
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool loggedIn = prefs.getBool(PreferenceConstants.isLoggedIn) ?? false;
  await LocalNotificationData.initialize(flutterLocalNotificationsPlugin);

  runApp(MyApp(
    loggedIn: loggedIn,
  ));
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider<NewsFeedsBloc>(
          create: (BuildContext context) => NewsFeedsBloc(),
        ),
        BlocProvider<PostBloc>(
          create: (BuildContext context) => PostBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MachineTest',
        theme: appTheme,
        initialRoute: widget.loggedIn ? '/AppBase' : '/LoginScreen',
        onGenerateRoute: _routeGenerator.generateRoute,
      ),
    );
  }
}

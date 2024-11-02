import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope_ease/network/bloc/login_bloc/login_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/signup/auth_bloc.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.popAndPushNamed(context, "/AppBase");
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
              ));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Phone number",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1), // Thick black border
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1), // Thick black border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1), // Thick black border
                      ),
                      // Adjusting the content padding to reduce height
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16), // Adjust vertical padding
                    ),
                  ),
                  const CustomSizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1), // Thick black border
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1), // Thick black border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1), // Thick black border
                      ),
                      // Adjusting the content padding to reduce height
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16), // Adjust vertical padding
                    ),
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text("Forgot password?",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                  const CustomSizedBox(height: 20),
                  ButtonWidget(
                      buttonPress: () {
                        context.read<AuthBloc>().add(
                              EmailPasswordLoginRequested(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            );
                      },
                      title: 'Log in',
                      width: screenWidth,
                      height: 50,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(1.00, 0.08),
                          end: Alignment(-1, -0.08),
                          colors: [Color(0xFF49108C), Color(0xFF8C59C8)],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0.09,
                      )),
                  CustomSizedBox(
                    height: 12,
                  ),
                  ButtonWidget(
                    buttonPress: () {
                      context.read<LoginBloc>().add(GoogleSignInEvent());
                    },
                    title: 'Sign in with Google',
                    icon: "assets/icons/google.svg",
                    width: screenWidth,
                    isLeftIconVisible: true,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      color: blackColor,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0.09,
                    ),
                  ),
                  const CustomSizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

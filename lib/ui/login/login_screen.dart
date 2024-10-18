import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope_ease/network/bloc/login_bloc/login_bloc.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is GoogleAuthSuccess) {

               Navigator.pushNamed(context, "/AppBase");
            } else if (state is GoogleAuthFailure) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/gallery.png"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const CustomSizedBox(height: 20),
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
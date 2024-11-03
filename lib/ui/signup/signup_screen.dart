import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shope_ease/network/bloc/social_media/signup/auth_bloc.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/button_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: Widgets().customAppbar("Signup", context,true),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthBloc(),
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Signup Successful")),
              );
              Navigator.popAndPushNamed(context, "/LoginScreen");

            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
              ));
            }
          }, builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedBox(
                      height: screenHeight * 0.15,
                    ),
                    const Text(
                      "Full Name",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      controller: _fullNameController,
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
                      "Mobile Number",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextField(
                      controller: _mobileController,
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
                    const Text(
                      "Email",
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
                    const CustomSizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                        buttonPress: () {
                          context.read<AuthBloc>().add(
                              EmailPasswordSignupRequested(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  name: _fullNameController.text,
                                  phone: _mobileController.text));
                        },
                        title: 'Sign up',
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
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

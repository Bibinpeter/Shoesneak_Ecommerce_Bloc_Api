// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/application/bloc/login/bloc/login_bloc.dart';
import 'package:shoesneak/application/presentation/screens/auth/registerscreen.dart';
import 'package:shoesneak/application/presentation/screens/auth/widget/textformfieldlogin.dart';
import 'package:shoesneak/application/presentation/screens/userhomescreen/user_homescreen.dart';
import 'package:shoesneak/application/presentation/widget/customloginbutton.dart';
import 'package:shoesneak/application/presentation/widget/widgets.dart';
import 'package:shoesneak/domain/core/constrains/const.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, State) {
          if (State is LoginLoading) {
            print("loading success");
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (State is LoginSuccessful) {
            print("login success");
            Navigator.pop(context);
            showTopSnackBar(
              curve: Curves.bounceOut,
              animationDuration: const Duration(milliseconds: 500),
              displayDuration: const Duration(milliseconds: 1500),
              snackBarPosition: SnackBarPosition.bottom,
              Overlay.of(context),
              const CustomSnackBar.success(message: "Login successfully"),
            );
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserHomeScreen(),));
          } else if (State is LoginError) {
            Navigator.pop(context);
            showTopSnackBar(
              curve: Curves.bounceOut,
              animationDuration: const Duration(milliseconds: 500),
              displayDuration: const Duration(milliseconds: 1500),
              snackBarPosition: SnackBarPosition.bottom,
              Overlay.of(context),
              const CustomSnackBar.error(message: " Error in Login"),
            );
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  children: [
                    Image.asset(
                      'assets/images/andres-jasso-PqbL_mxmaUE-unsplash.jpg',
                      fit: BoxFit.cover,
                    ),
                    const AnimatedCircularIcon(
                        size: 60, iconData: Icons.person_2_outlined),
                  ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipPath(
                        clipper: BackgroundClipper(),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.black.withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/pngwing.com.png',
                                width: 200,
                                height: 200,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const AnimatedCircularIcon(
                              size: 60,
                              iconData: Icons.person_2_outlined,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'LOGIN',
                              style: GoogleFonts.lato(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextformfieldLogin(
                                controller: emailController,
                                hintText: "email",
                                errorText: 'enter valid email'),
                            kSizedBoxH20,
                            TextformfieldLogin(
                                controller: passwordcontroller,
                                hintText: "password",
                                errorText: "enter the valid password"),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const Registerscreen(),
                                    ));
                                  },
                                  child: const Text(
                                    'REGISTER',
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(color: Colors.greenAccent),
                                  ),
                                ),
                              ],
                            ),
                            CustomRoundedLoadingButtonS(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // If validation succeeds, trigger login event
                                    BlocProvider.of<LoginBloc>(context).add(
                                      LoginButtonPressed(
                                        email: emailController.text,
                                        password: passwordcontroller.text,
                                      ),
                                    );
                                  }
                                },
                                buttonText: "LOGIN")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

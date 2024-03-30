import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/application/bloc/signup/bloc/signup_bloc.dart';
import 'package:shoesneak/application/presentation/screens/auth/loginscreen.dart';
import 'package:shoesneak/application/presentation/screens/userhomescreen/user_homescreen.dart';
import 'package:shoesneak/application/presentation/widget/formfieldregister.dart';
import 'package:shoesneak/application/presentation/widget/roundedloadingbutton.dart';
import 'package:shoesneak/application/presentation/widget/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController firstnamecontroller = TextEditingController();
    TextEditingController lastnamecontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController phonrcontroller = TextEditingController();
    TextEditingController refferalcodecontroller = TextEditingController();
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            print("signup loading success");
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is SignUpSuccessful) {
            print("signed starte successful");
            Navigator.pop(context);
            showTopSnackBar(
              curve: Curves.bounceOut,
              animationDuration: const Duration(milliseconds: 500),
              displayDuration: const Duration(milliseconds: 1500),
              snackBarPosition: SnackBarPosition.bottom,
              Overlay.of(context),
              const CustomSnackBar.success(message: "Registered successfully"),
            );
           
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => UserHomeScreen(),
                ),
                (route) => false);
          } else if (state is SignUpError) {
            Navigator.pop(context);
            showTopSnackBar(
              curve: Curves.bounceOut,
              animationDuration: const Duration(milliseconds: 500),
              displayDuration: const Duration(milliseconds: 1500),
              snackBarPosition: SnackBarPosition.bottom,
              Overlay.of(context),
              const CustomSnackBar.error(message: "Error in Login"),
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
                      'assets/images/andres-jasso-u4unYsXQHnE-unsplash.jpg',
                      fit: BoxFit.cover,
                    ),
                    const AnimatedCircularIcon(
                      size: 60,
                      iconData: Icons.person_2_outlined,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black.withOpacity(0.6),
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
                                  Colors.black.withOpacity(0.3),
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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const AnimatedCircularIcon(
                                  size: 60,
                                  iconData: Icons.person_add,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'REGISTER',
                                  style: GoogleFonts.lato(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormRegister(
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email,
                                controller: emailController,
                                hintText: "Email id",
                                errorText: "Enter valid email"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormRegister(
                                keyboardType: TextInputType.name,
                                prefixIcon: Icons.person,
                                controller: firstnamecontroller,
                                hintText: "First Name",
                                errorText: "enter valid first name"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormRegister(
                                keyboardType: TextInputType.name,
                                prefixIcon: Icons.person,
                                controller: lastnamecontroller,
                                hintText: "Last Name ",
                                errorText: "enter valid second name"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormRegister(
                                keyboardType: TextInputType.text,
                                prefixIcon: Icons.password,
                                controller: passwordcontroller,
                                obscureText: true,
                                hintText: "Password",
                                errorText: "enter valid password"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormRegister(
                                keyboardType: TextInputType.number,
                                prefixIcon: Icons.phone_android,
                                controller: phonrcontroller,
                                hintText: "Phone Number",
                                errorText: "enter valid phone number"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormRegister(
                                keyboardType: TextInputType.text,
                                prefixIcon: Icons.code,
                                controller: refferalcodecontroller,
                                hintText: "Refferal Code",
                                errorText: "enter valid refferal code"),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomRoundedLoadingButtonR(
                              onPressed: () {
                                if (refferalcodecontroller.text.isEmpty ||
                                    formKey.currentState!.validate()) {
                                  BlocProvider.of<SignupBloc>(context).add(
                                      SignupButtonPressed(
                                          email: emailController.text,
                                          firstname: firstnamecontroller.text,
                                          lastname: lastnamecontroller.text,
                                          password: passwordcontroller.text,
                                          phonenumber: phonrcontroller.text,
                                          refferalcode:
                                              refferalcodecontroller.text));
                                }
                              },
                              buttonText: "CONFIRM REGISTRATION",
                              letterSpacing: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                                },
                                child: Text(
                                  'Already have an account? Log in',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.greenAccent),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

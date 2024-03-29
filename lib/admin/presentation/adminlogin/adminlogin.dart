import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/admin/bussiness_logic/loginbloc/login_bloc_bloc.dart';
import 'package:shoesneak/admin/presentation/bottomnav/bottomnav.dart';
import 'package:shoesneak/presentation/widget/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Adminlogin extends StatefulWidget {
  const Adminlogin({Key? key}) : super(key: key);

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBlocBloc, LoginBlocState>(
        listener: (context, state) {
          if (state is LoginBlocLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else if (state is LoginBlocSuccess) {
            showTopSnackBar(
              curve: Curves.bounceOut,
              animationDuration: const Duration(milliseconds: 500),
              displayDuration: const Duration(milliseconds: 1500),
              snackBarPosition: SnackBarPosition.bottom,
            Overlay.of(context),const CustomSnackBar.success(message:"Login successfully"),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavBar(),
              ),
              (route) => false,
            );
          } else if (state is LoginBlocError) {
            showTopSnackBar(
               snackBarPosition: SnackBarPosition.bottom,
              Overlay.of(context),
              const CustomSnackBar.error(message: "Error Occured In Login"),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  AnimatedCircularIcon(
                    size: 100,
                    iconData: Icons.admin_panel_settings
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "ADMIN LOGIN",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            FloatingActionButton(
                              backgroundColor:
                                  const Color.fromARGB(255, 168, 186, 196),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBlocBloc>(context)
                                      .add(AdminLoginButtonPressed(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ));
                                }
                              },
                              child: const Icon(Icons.login),
                            ),
                            const SizedBox(height: 10),
                            const Text("Login"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

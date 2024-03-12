import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/bussiness/auth/bloc/splashbloc_bloc.dart';
import 'package:shoesneak/bussiness/auth/bloc/splashbloc_event.dart';
import 'package:shoesneak/bussiness/auth/bloc/splashbloc_state.dart';
import 'package:shoesneak/presentation/screens/boardingscreens/boardingscreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/nike-logo-5.png'),
      splashIconSize: 200,
      nextScreen: BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(SetSplash()),
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashLoadedState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Boardingscreen()),
              );
            }
          },
          builder: (context, state) {
            return Container(); // Placeholder widget while waiting for state
          },
        ),
      ),
      splashTransition: SplashTransition.scaleTransition,

      duration: 2000, // Adjust duration as needed
    );
  }
}

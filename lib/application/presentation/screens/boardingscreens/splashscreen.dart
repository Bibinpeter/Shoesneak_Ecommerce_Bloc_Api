import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';
import 'package:shoesneak/application/bloc/splash/bloc/splash_bloc.dart';
import 'package:shoesneak/application/presentation/screens/auth/loginscreen.dart';
import 'package:shoesneak/application/presentation/screens/boardingscreens/diversion.dart';

class SplashScreen extends StatelessWidget {        
  const SplashScreen({Key? key}) : super(key: key);
  //////////////////////////
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/nike-logo-5.png'),
      splashIconSize: 200,
      nextScreen: BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(SetSplash()),
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) async{
            if (state is SplashLoadedState) {
              final userLoggedInToken = await getToken();
               if (userLoggedInToken == ''){
                  Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) => const VideoApp()),
                  );
               }else{
                 Navigator.pushReplacement(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(builder: (context) =>const LoginScreen() ),
              );
               }
            }
          },
          builder: (context, state) {
            return Container(); 
          },
        ),
      ),
      splashTransition: SplashTransition.scaleTransition,

      duration: 2000, // Adjust duration as needed
    );
  }
  
 
}
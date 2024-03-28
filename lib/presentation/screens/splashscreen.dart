import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/admin/presentation/adminlogin/adminlogin.dart';
import 'package:shoesneak/admin/presentation/bottomnav/bottomnav.dart';
import 'package:shoesneak/admin/utils/functions/functions.dart';
import 'package:shoesneak/bloc/auth/bloc/splashbloc_bloc.dart';
import 'package:shoesneak/bloc/auth/bloc/splashbloc_event.dart';
import 'package:shoesneak/bloc/auth/bloc/splashbloc_state.dart';

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
                context,
                MaterialPageRoute(builder: (context) => Adminlogin()),
              );
               }else{
                 Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBar()),
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
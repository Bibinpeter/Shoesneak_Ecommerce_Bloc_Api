import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shoesneak/admin/bussiness_logic/admincategory/bloc/categorybloc_bloc.dart';
import 'package:shoesneak/admin/bussiness_logic/loginbloc/login_bloc_bloc.dart';
import 'package:shoesneak/admin/bussiness_logic/naviagationbar/bloc/navbloc_bloc.dart';
import 'package:shoesneak/admin/bussiness_logic/product/bloc/product_bloc.dart';
import 'package:shoesneak/application/bloc/login/bloc/login_bloc.dart';
import 'package:shoesneak/application/bloc/navbar/bloc/navbar_bloc.dart';
import 'package:shoesneak/application/bloc/signup/bloc/signup_bloc.dart';
import 'package:shoesneak/application/bloc/splash/bloc/splash_bloc.dart';
import 'package:shoesneak/application/presentation/screens/boardingscreens/splashscreen.dart';

final http.Client httpClient = http.Client();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginBlocBloc(httpClient)),
          BlocProvider(create: (_) => NavblocBloc()),
           BlocProvider(create: (_) => ProductBloc()),
          BlocProvider(create: (_) => CategoryblocBloc()),
          BlocProvider(create: (_) => SplashBloc()),
          BlocProvider(create: (_) => SignupBloc()),
          BlocProvider(create: (_) => LoginBloc()),
          BlocProvider(create: (_) => NavbarBloc())
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
  }
}

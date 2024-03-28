import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:shoesneak/admin/bussiness_logic/admincategory/bloc/categorybloc_bloc.dart';
import 'package:shoesneak/admin/bussiness_logic/loginbloc/login_bloc_bloc.dart';
import 'package:shoesneak/admin/bussiness_logic/naviagationbar/bloc/navbloc_bloc.dart';
import 'package:shoesneak/bloc/auth/bloc/splashbloc_bloc.dart';
import 'package:shoesneak/presentation/screens/splashscreen.dart';


final http.Client httpClient = http.Client();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
      MultiBlocProvider(
        providers:[
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => LoginBlocBloc(httpClient)),
        BlocProvider(create: (_) =>NavblocBloc()),
        BlocProvider(create: (_)=>CategoryblocBloc())
        ],
       
        child:const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ));
    
  }
}

  

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/application/bloc/navbar/bloc/navbar_bloc.dart';
import 'package:shoesneak/application/presentation/screens/bottomnav/widget/navwidget.dart';
import 'package:shoesneak/application/presentation/screens/userscreens/cartscreen.dart';
import 'package:shoesneak/application/presentation/screens/userscreens/productscreen.dart';
import 'package:shoesneak/application/presentation/screens/userscreens/profile_screen.dart';
import 'package:shoesneak/application/presentation/screens/userscreens/user_homescreen.dart';

class Bottomnavuser extends StatelessWidget {
  const Bottomnavuser({super.key});

  @override
   Widget build(BuildContext context) {
    return BlocProvider<NavbarBloc>(
      create: (context) => NavbarBloc(),
      child: BlocBuilder<NavbarBloc, NavbarState>(
        builder: (context, state) {
          Widget currentScreen = const UserHomeScreen(); // Default screen
          if (state is HomeSelected) {
            currentScreen = const UserHomeScreen();
          } else if (state is ProductScreenSelected) {
            currentScreen = const Productscreen();
          } else if (state is CartScreenSelected) {
            currentScreen = const CartScreen();
          } else if (state is ProfileScreenSelected) {
            currentScreen = const profilescreen();
          }

          return Scaffold(
            body: currentScreen,
            bottomNavigationBar: const GnavWidget(),
          );
        },
      ),
    );
  }
}
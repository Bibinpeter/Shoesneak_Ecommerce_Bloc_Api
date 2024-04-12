import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoesneak/admin/application/bussiness_logic/naviagationbar/bloc/navbloc_bloc.dart';
import 'package:shoesneak/admin/application/presentation/add_product/add_cart.dart';
import 'package:shoesneak/admin/application/presentation/admin_home_screen/admin_homescreen.dart';
import 'package:shoesneak/admin/application/presentation/offers_and_coupons/offers_nd_coupons.dart';
import 'package:shoesneak/admin/application/presentation/users_screen/users_screen.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

 

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavblocBloc>(
      create: (context) => NavblocBloc(),
      child: BlocBuilder<NavblocBloc, NavblocState>(
        builder: (context, state) {
          int currentIndex = 0;
          Widget currentScreen = const AdminHome();

          if (state is HomeSelected) {
            currentScreen = const AdminHome();
          } else if (state is AddProductSelected) {
            currentScreen =  AddCategoryscrn();
            currentIndex = 1;
          } else if (state is OffersCouponsSelected) {
            currentScreen = const OffersAndCouponsAddingScreen();
            currentIndex = 2;
          } else if (state is UserSelected) {
            currentScreen = const UsersScreen();
            currentIndex = 3;
          }

          return Scaffold(
            body: currentScreen,
            bottomNavigationBar: SlidingClippedNavBar(
              backgroundColor: Colors.white,
              onButtonPressed: (index) {
                switch (index) {
                  case 0:
                    context.read<NavblocBloc>().add(HomePressed());
                    break;
                  case 1:
                    context.read<NavblocBloc>().add(AddProductPressed());
                    break;
                  case 2:
                    context.read<NavblocBloc>().add(OffersCouponsPressed());
                    break;
                  case 3:
                    context.read<NavblocBloc>().add(UserPressed());
                    break;
                  default:
                    break;
                }
              },
              iconSize: 30,
              activeColor: Colors.black,
             inactiveColor: Colors.deepPurple,
              selectedIndex: currentIndex,
              barItems: [
                BarItem(
                  icon: Icons.home,
                  title: 'Home',
                ),
                BarItem(
                  icon: Icons.add,
                  title: 'Add',
                ),
                BarItem(
                  icon: Icons.local_offer,
                  title: 'Add Deals',
                ),
                BarItem(
                  icon: Icons.people,
                  title: 'Users',
                ),
              ],
            ),
          );
        },
  ),
);
}
}
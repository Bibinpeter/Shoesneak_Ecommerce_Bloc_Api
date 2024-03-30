
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shoesneak/application/bloc/navbar/bloc/navbar_bloc.dart';
import 'package:shoesneak/domain/core/constrains/const.dart';

class GnavWidget extends StatelessWidget {
  const GnavWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GNav(
     
      rippleColor:kblackcolor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      gap: 8,
      activeColor: const Color.fromARGB(255, 1, 255, 255),
      iconSize: 22,
      tabBackgroundColor: Colors.blueGrey.withOpacity(0.7),
      duration: const Duration(milliseconds: 250),
      tabs: [ 
        GButton(
          icon: Icons.home,
          text: 'Home',
          textStyle: GoogleFonts.poppins(fontSize: 16, color:kwhiteColor),
          onPressed: () => context.read<NavbarBloc>().add(HomePressed()),
        ),
        GButton(
          icon: Icons.add_shopping_cart,
          text: 'Products',
          textStyle: GoogleFonts.poppins(fontSize: 16, color:kwhiteColor),
          onPressed: () => context.read<NavbarBloc>().add((ProductPressed())),
        ),
        GButton(
          icon: Icons.shopping_bag,
          text: 'Cart',
          textStyle: GoogleFonts.poppins(fontSize: 16, color:kwhiteColor),
          onPressed: () => context.read<NavbarBloc>().add(CartPressed()),
        ),
        GButton(
          icon: Icons.person,
          text: 'Profile',
          textStyle:GoogleFonts.poppins(fontSize: 16, color: kwhiteColor),
          onPressed: () => context.read<NavbarBloc>().add(ProfilePressed()),
        ),
      ],
    );
  }
}
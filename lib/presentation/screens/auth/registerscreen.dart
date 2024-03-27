import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/presentation/screens/auth/widgets.dart';
import 'package:shoesneak/presentation/screens/userhomescreen/user_homescreen.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              children: [
                Image.asset(
                  'assets/images/andres-jasso-u4unYsXQHnE-unsplash.jpg',
                  fit: BoxFit.cover,
                ),
                AnimatedCircularIcon(
                  size: 60,
                  iconData: Icons.person_2_outlined,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
          SingleChildScrollView(
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
                            Colors.black.withOpacity(0.4),
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
                  child: Row(
                    children: [
                      AnimatedCircularIcon(
                        size: 60,
                        iconData: Icons.person_2_outlined,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'REGISTER',
                        style: GoogleFonts.lato(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 205, 204, 209)),
                        decoration: const InputDecoration(
                          labelText: "Email id",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        style: const TextStyle(
                            color: Color.fromARGB(255, 170, 169, 174)),
                        decoration: const InputDecoration(
                          labelText: "Enter the password",
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => UserHomeScreen(),
                            child: Image.asset(
                              "assets/images/login (1).png",
                              width: 60, 
                              height: 60, 
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
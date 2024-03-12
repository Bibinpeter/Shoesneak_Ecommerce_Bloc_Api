import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Boardingscreen extends StatefulWidget {
  const Boardingscreen({Key? key}) : super(key: key);

  @override
  State<Boardingscreen> createState() => _BoardingscreenState();
}

class _BoardingscreenState extends State<Boardingscreen> {
  List<AssetImage> pages = [
    const AssetImage("assets/images/pngegg (1).png"),
    const AssetImage("assets/images/pngegg.png"),
    const AssetImage("assets/images/pngegg (10).png"),
  ];

  List<String> texts = [
    "JUST DO IT...",  
    "FIND YOUR \n   GREATNESS",
    "MAKE IT MORE\n   PERFECT",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        radius: 25,
        verticalPosition: 0.85,
        colors: const [
          Color.fromARGB(255, 86, 144, 238),
          Color.fromARGB(255, 238, 71, 71),
          Color.fromARGB(255, 23, 206, 30)
        ],
        itemBuilder: (index) {
          int pageIndex = index % pages.length;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: pages[pageIndex],
                width: 350,
                height: 350,
              ),
              const SizedBox(height: 10),
              Text(
                texts[pageIndex],
                style: GoogleFonts.lato(
                  fontSize: 35,
                  color: Colors.white,
                  letterSpacing: 6,
                ),
              ),
            ]
            ,
          );
          

        },
        
      ),
 
    
    );
  }
}

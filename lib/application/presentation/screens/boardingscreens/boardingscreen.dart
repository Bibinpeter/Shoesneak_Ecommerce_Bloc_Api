import 'package:action_slider/action_slider.dart';
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesneak/application/presentation/screens/boardingscreens/diversion.dart';
 

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final List<AssetImage> pages = [
    const AssetImage("assets/images/pngegg (1).png"),
    const AssetImage("assets/images/pngegg.png"),
    const AssetImage("assets/images/Nike-Shoes-Air-Max-PNG-Image.png"),
  ];

  List<String> texts = [
    "JUST DO IT...",  
    "FIND YOUR \n   GREATNESS",
    "MAKE IT MORE\n   PERFECT",
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        radius: 30, 
        verticalPosition: 0.85,
        colors: const [
          Color.fromARGB(255, 43, 118, 246),
          Color.fromARGB(255, 223, 25, 75),
          Color.fromARGB(255, 13, 216, 131),
        ],
        itemCount: pages.length,
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
               Text(
                texts[pageIndex],
                style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 6,
                ),
              ),
              if (index ==
                  pages.length - 1)  
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ActionSlider.standard(
                    child: const Text('Slide to join'),
                    action: (controller) async {
                      controller.loading(); 
                      await Future.delayed(const Duration(seconds: 2));
                      controller.success();

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>VideoApp(),
                        ),
                        (route) => false,
                      );
                    },
                    // ... other parameters for ActionSlider
                  ),
                ),
            ],
          );
        },
),
);
}
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_container/liquid_container.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

class BigNoiseLiquidWidget extends StatefulWidget {
  const BigNoiseLiquidWidget({Key? key}) : super(key: key);

  @override
  _BigNoiseLiquidWidgetState createState() => _BigNoiseLiquidWidgetState();
}

class _BigNoiseLiquidWidgetState extends State<BigNoiseLiquidWidget> {
  String label = 'Login';
  final optionsParam = Options(
    layers: [ 
      LayerModel(
        points: [], 
        viscosity: 0.9,
        touchForce: 30,
        forceLimit: 15,
        color: Color.fromARGB(255, 62, 63, 62),
      ),
      LayerModel(
        points: [],
        viscosity: 0.9,
        touchForce: 50,
        forceLimit: 10,
        color: Color.fromARGB(255, 121, 121, 197),
      ),
      LayerModel(
        points: [],
        viscosity: 0.9,
        touchForce: 50,
        forceLimit: 10,
        color: Color.fromARGB(255, 104, 237, 232),
      ),
    ],
    gap: 30,
    noise: 30,
    forceFactorBuild: 10,
    forceFactorOnTap: 150,
    scaleOptionLayer: [1, 0.9, 0.8],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150, // Adjust the height as needed
      width: 150, // Adjust the width as needed
      margin: const EdgeInsets.only(left: 10, right: 30, top: 100),
      child: LiquidContainer(
        onTap: _onTapToLiquidButton,
        optionsParam: optionsParam,
        boxDecorationLabel: _borderForm(),
        child: _buildForegroundChild(),
      ),
    );
  }

  BoxDecoration _borderForm() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(80),
        bottomLeft: Radius.circular(150),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  void _onTapToLiquidButton() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF00FFD5),
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),  
    );
  }

  Row _buildForegroundChild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 30,
            color: Colors.white,
            letterSpacing: 6,
          ),
        ),
      ],
    );
  }
}



class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.1), // Set your desired button color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18,color: Colors.white.withOpacity(0.5)),
      ),
    );
  }
}
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class AnimatedCircularIcon extends StatelessWidget {
  final double size;
  final IconData iconData;

  AnimatedCircularIcon({required this.size, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WidgetCircularAnimator(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            iconData,
            color: Color.fromARGB(255, 15, 112, 223),
            size: size * 0.5, // Adjust the icon size based on the widget size
          ),
        ),
        size: size,
      ),
    );
  }
}



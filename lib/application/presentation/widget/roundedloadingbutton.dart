import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class CustomRoundedLoadingButtonR extends StatefulWidget {
  final Function onPressed;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double letterSpacing; 

  const CustomRoundedLoadingButtonR({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.buttonColor = Colors.black, 
    this.textColor = Colors.white,  
    this.letterSpacing = 0.0,  
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomRoundedLoadingButtonState createState() =>
      _CustomRoundedLoadingButtonState();
}

class _CustomRoundedLoadingButtonState extends State<CustomRoundedLoadingButtonR> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: _btnController,
      onPressed: () {
        _btnController.start();
        widget.onPressed();
        _doSomething(); // Call the internal function
      },
      color: widget.buttonColor,
      child: Text(
        widget.buttonText,
        style: GoogleFonts.poppins(
          color: widget.textColor,
          letterSpacing: widget.letterSpacing, // Set letterSpacing from the parameter
        ),
      ),
    );
  }

  void _doSomething() async {
    Timer(const Duration(seconds: 3), () {
      _btnController.success();
    });
  }
}

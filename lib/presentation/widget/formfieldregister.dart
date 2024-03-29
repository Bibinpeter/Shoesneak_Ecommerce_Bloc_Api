import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormRegister extends StatelessWidget {
  const TextFormRegister({
    Key? key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    required this.errorText,
    this.suffixIcon,
    this.obscureText, required TextInputType keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final String errorText;
  final IconData? suffixIcon;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        obscureText: obscureText ?? false,
        controller: controller,
        style: const TextStyle(color: Colors.greenAccent),
        decoration: InputDecoration(
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15, 
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.white,size: 20,)
              : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorText;
          }
          return null;  
        },
      ),
    );
  }
}
